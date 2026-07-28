#!/bin/bash
# scripts/update-casks.sh
# Checks for new versions of all casks and updates them in-place.
# Designed to run in CI (GitHub Actions), but also works locally.
#
# Usage: ./scripts/update-casks.sh
#
# For each cask with an available update, the file is modified in-place.
# The caller (GitHub Actions workflow) creates a PR from the changes.
#
# Environment variable (optional):
#   GITHUB_OUTPUT  - set by GitHub Actions for step output

set -euo pipefail

# ── Configuration ──────────────────────────────────────────────────────────
CASK_DIR="Casks"

# Format: cask_name|api_url|check_type
#   check_type: "api" = JSON API returns {version, downloads.macos.*.sha256}
CASKS=(
  "eye-sentry|https://rustx-labs.github.io/api/updates/eye-sentry|api"
  "novadb|https://rustx-labs.github.io/api/updates/novadb|api"
  "sky-monitor|https://rustx-labs.github.io/api/updates/sky-monitor|api"
  "apifire||webpage"
)

# ── Helpers ────────────────────────────────────────────────────────────────

log()  { printf "  %s\n" "$*"; }
ok()   { printf "  \033[32m✓\033[0m %s\n" "$*"; }
skip() { printf "  \033[33m-\033[0m %s\n" "$*"; }
warn() { printf "  \033[31m!\033[0m %s\n" "$*"; }
info() { printf "  \033[34m→\033[0m %s\n" "$*"; }

# Extract a version string from a cask file.
cask_version() {
  sed -n 's/^[[:space:]]*version "\(.*\)"/\1/p' "$1" | head -1
}

# Extract arm sha256 from a cask file.
cask_arm_sha256() {
  sed -n 's/.*sha256 arm: "\([^"]*\)".*/\1/p' "$1" | head -1
}

# Extract intel sha256 from a cask file.
cask_intel_sha256() {
  sed -n 's/.*intel: "\([^"]*\)".*/\1/p' "$1" | head -1
}

# Compare two semver strings. Returns 0 (true) if $1 < $2.
ver_lt() {
  [ "$1" = "$2" ] && return 1
  [ "$(printf '%s\n%s' "$1" "$2" | sort -V | head -1)" = "$1" ]
}

# Portable sed in-place: works on both macOS (BSD sed) and Linux (GNU sed).
sed_i() {
  if sed --version 2>/dev/null | grep -q GNU; then
    sed -i "$@"
  else
    sed -i '' "$@"
  fi
}

# ── Main ───────────────────────────────────────────────────────────────────

main() {
  local all_updated=0
  local pr_body=""

  echo "═══════════════════════════════════════════════"
  echo "  Homebrew Tap — Cask Version Checker"
  echo "═══════════════════════════════════════════════"
  echo ""

  for entry in "${CASKS[@]}"; do
    IFS='|' read -r cask_name api_url check_type <<< "$entry"
    cask_file="${CASK_DIR}/${cask_name}.rb"

    if [ ! -f "$cask_file" ]; then
      warn "cask file not found: $cask_file"
      continue
    fi

    # Read current cask values
    current_version=$(cask_version "$cask_file")
    current_arm_sha=$(cask_arm_sha256 "$cask_file")
    current_intel_sha=$(cask_intel_sha256 "$cask_file")

    echo "───────────────────────────────────────────"
    echo "  ${cask_name}  (current: ${current_version})"
    echo "───────────────────────────────────────────"

    latest_version=""
    arm_sha256=""
    intel_sha256=""

    # ── Fetch latest version ──────────────────────
    case "$check_type" in
      api)
        info "checking API: ${api_url}"
        local response
        response=$(curl -sfL --max-time 15 "$api_url" 2>/dev/null || true)
        if [ -z "$response" ]; then
          warn "API unreachable, skipping"
          continue
        fi

        if ! command -v jq &>/dev/null; then
          warn "jq not available, skipping"
          continue
        fi

        latest_version=$(echo "$response" | jq -r '.version // empty')
        arm_sha256=$(echo "$response" | jq -r '.downloads.macos.aarch64.sha256 // empty')
        intel_sha256=$(echo "$response" | jq -r '.downloads.macos.x86_64.sha256 // empty')

        if [ -z "$latest_version" ]; then
          warn "could not parse version from API response"
          continue
        fi
        ;;

      webpage)
        # For apifire: try to find the latest version from Vercel Blob Storage
        local base_url="https://msjiarczdjxuxc5t.public.blob.vercel-storage.com/releases"
        local found=""

        IFS='.' read -r major minor patch <<< "$current_version"

        # Candidates: patch bump, minor bump, major bump
        for candidate in \
          "${major}.${minor}.$((patch + 1))" \
          "${major}.$((minor + 1)).0" \
          "$((major + 1)).0.0"; do
          local test_url="${base_url}/v${candidate}/apifire-v${candidate}-aarch64-apple-darwin.tar.gz"
          if curl -sfL -o /dev/null -w "%{http_code}" --max-time 10 "$test_url" 2>/dev/null | grep -q "200"; then
            found="$candidate"
            info "found v${candidate} at blob storage"
          fi
        done

        if [ -z "$found" ]; then
          skip "no newer version detected for ${cask_name}"
          continue
        fi

        latest_version="$found"
        ;;

      *)
        warn "unknown check type: ${check_type}"
        continue
        ;;
    esac

    # ── Compare ───────────────────────────────────
    if [ "$current_version" = "$latest_version" ]; then
      ok "up to date"
      continue
    fi

    if ! ver_lt "$current_version" "$latest_version"; then
      info "current ($current_version) >= latest ($latest_version)? skipping"
      continue
    fi

    echo ""
    info "UPDATE AVAILABLE: ${current_version} → ${latest_version}"

    # ── Download & compute sha256 (webpage type needs manual download) ──
    if [ "$check_type" = "webpage" ]; then
      local base_url="https://msjiarczdjxuxc5t.public.blob.vercel-storage.com/releases"
      for pair in "aarch64 arm_sha256" "x86_64 intel_sha256"; do
        read -r arch sha_var <<< "$pair"
        local dl_url="${base_url}/v${latest_version}/apifire-v${latest_version}-${arch}-apple-darwin.tar.gz"
        info "  downloading ${arch}…"

        local tmpfile
        tmpfile=$(mktemp)
        if curl -sfL --max-time 120 "$dl_url" -o "$tmpfile" 2>/dev/null; then
          local sha
          sha=$(shasum -a 256 "$tmpfile" | awk '{print $1}')
          rm -f "$tmpfile"
          if [ "$sha_var" = "arm_sha256" ]; then
            arm_sha256="$sha"
          else
            intel_sha256="$sha"
          fi
          ok "  sha256 (${arch}): ${sha}"
        else
          warn "  failed to download ${arch}, skipping update for this cask"
          rm -f "$tmpfile"
          continue 2
        fi
      done
    fi

    # ── Update the cask file ──────────────────────
    # version line
    sed_i "s/version \"${current_version}\"/version \"${latest_version}\"/" "$cask_file"
    # sha256 arm (first line, ends with comma)
    sed_i "s/sha256 arm: \"${current_arm_sha}\"/sha256 arm: \"${arm_sha256}\"/" "$cask_file"
    # sha256 intel (second line)
    sed_i "s/intel: \"${current_intel_sha}\"/intel: \"${intel_sha256}\"/" "$cask_file"

    ok "${cask_name} updated: ${current_version} → ${latest_version}"
    all_updated=$((all_updated + 1))
    printf -v pr_body "%s- **%s**: %s → %s\\n" "$pr_body" "$cask_name" "$current_version" "$latest_version"
    echo ""
  done

  # ── Summary ──────────────────────────────────────
  echo "═══════════════════════════════════════════════"
  if [ "$all_updated" -gt 0 ]; then
    echo "  ✅ ${all_updated} cask(s) updated."
    echo ""
    echo -e "$pr_body"
  else
    echo "  ✓ All casks up to date."
  fi
  echo "═══════════════════════════════════════════════"

  # Write step outputs for GitHub Actions
  if [ -n "${GITHUB_OUTPUT:-}" ]; then
    echo "updated=${all_updated}" >> "$GITHUB_OUTPUT"
    echo "pr_body<<EOF" >> "$GITHUB_OUTPUT"
    echo -e "$pr_body" >> "$GITHUB_OUTPUT"
    echo "EOF" >> "$GITHUB_OUTPUT"
  fi
}

main "$@"

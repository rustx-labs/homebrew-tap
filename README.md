<p align="center">
  <a href="https://github.com/rustx-labs/homebrew-tap/actions/workflows/publish.yml">
    <img src="https://github.com/rustx-labs/homebrew-tap/actions/workflows/publish.yml/badge.svg" alt="CI Status">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License">
  </a>
  <a href="https://github.com/rustx-labs/homebrew-tap/stargazers">
    <img src="https://img.shields.io/github/stars/rustx-labs/homebrew-tap?style=social" alt="GitHub Stars">
  </a>
  <a href="https://github.com/rustx-labs/homebrew-tap/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/rustx-labs/homebrew-tap" alt="Contributors">
  </a>
  <a href="https://github.com/rustx-labs/homebrew-tap/commits/main">
    <img src="https://img.shields.io/github/last-commit/rustx-labs/homebrew-tap" alt="Last Commit">
  </a>
  <a href="https://github.com/rustx-labs/homebrew-tap">
    <img src="https://img.shields.io/github/repo-size/rustx-labs/homebrew-tap" alt="Repo Size">
  </a>
</p>

<p align="center">
  <a href="README.zh.md">🇨🇳 中文</a>
</p>

<h1 align="center">RustX Labs Homebrew Tap</h1>

<p align="center">
  <b>Your one-stop Homebrew tap for RustX Labs macOS apps and developer tools.</b><br>
  Install, upgrade, and manage everything with a single <code>brew</code> command.
</p>

---

## What is This?

This repository is an official [Homebrew tap](https://docs.brew.sh/Taps) maintained by **RustX Labs**. It packages our macOS desktop applications and CLI tools as Homebrew casks, so you can install and keep them up to date effortlessly—no manual downloads, no drag-and-drop, no hassle.

## Quick Start

Tap the repository once:

```bash
brew tap rustx-labs/tap
```

Then install any app instantly:

```bash
brew install --cask eye-sentry
brew install --cask apifire
brew install --cask sky-monitor
brew install --cask novadb
```

## Available Casks

<table>
<tr>
<td width="50%" valign="top">

### Eye Sentry

Your personal macOS eye-care companion. Smart reminders, focus timers, and break prompts help you maintain healthy screen habits throughout the day.

- **Install**: `brew install --cask eye-sentry`
- **Target**: `/Applications/eye-sentry.app`
- **Best for**: Anyone who spends long hours in front of a screen and wants to protect their vision

</td>
<td width="50%" valign="top">

### ApiFire

A blazing-fast CLI toolkit for API testing and developer workflows. Build, debug, and automate HTTP requests directly from your terminal.

- **Install**: `brew install --cask apifire`
- **Target**: `apifire` command-line binary
- **Best for**: Backend developers, QA engineers, and DevOps pros who live in the terminal

</td>
</tr>
<tr>
<td width="50%" valign="top">

### Sky Monitor

A lightweight macOS menu-bar system monitor. It lives in your tray, shows real-time CPU, memory, disk, temperature, and network stats at a glance, and opens a detailed dropdown panel on click.

- **Install**: `brew install --cask sky-monitor`
- **Target**: `/Applications/sky-monitor.app`
- **Best for**: Power users and developers who want instant system metrics without leaving the menu bar

</td>
<td width="50%" valign="top">

### NovaDB

The next-generation AI-native database client. NovaDB pairs an intelligent agent with a modern UI so you can query, visualize, and manage your data using natural language.

- **Install**: `brew install --cask novadb`
- **Target**: `/Applications/NovaDB.app`
- **Best for**: Developers and data analysts who want an AI copilot for their databases

</td>
</tr>
</table>

## Upgrade

Update the tap and upgrade all installed casks:

```bash
brew update
brew upgrade --cask
```

Or upgrade a specific app:

```bash
brew upgrade --cask eye-sentry
```

## Brewfile Example

Managing a new Mac? Drop this into your `Brewfile` and run `brew bundle`:

```ruby
tap "rustx-labs/tap"
cask "eye-sentry"
cask "apifire"
cask "sky-monitor"
cask "novadb"
```

## Requirements

- **macOS**: 11 Big Sur or later
- **Architecture**: Apple Silicon (ARM64) or Intel (x86_64)
- **Homebrew**: 4.0 or later ([install guide](https://docs.brew.sh/Installation))

## Notes

- If an app already exists in `/Applications`, Homebrew will replace it seamlessly.
- `eye-sentry` and `sky-monitor` automatically clear macOS quarantine attributes and launch after installation.
- `apifire` installs a signed CLI binary and clears quarantine attributes during setup.
- `novadb` follows the same post-install flow as our other native apps: quarantine cleanup and auto-launch.

## Documentation

- [Homebrew Documentation](https://docs.brew.sh)
- `brew help` and `man brew`

## License

Licensed under the [Apache License 2.0](LICENSE).

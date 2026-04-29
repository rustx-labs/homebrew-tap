# RustX Labs Homebrew Tap

Homebrew tap for RustX Labs macOS distributions.

This repository provides Homebrew casks for desktop apps and developer tools published by RustX Labs, so macOS users can install and upgrade them with standard `brew` commands.

## Supported Projects

### Eye Sentry

A macOS eye care and focus assistant.

- Homebrew cask: `eye-sentry`
- Install target: `/Applications/eye-sentry.app`
- Best for: users who want reminder, focus, and eye-care assistance as a native macOS app

Install with:

```bash
brew install --cask rustx-labs/tap/eye-sentry
```

Or after tapping the repository:

```bash
brew tap rustx-labs/tap
brew install --cask eye-sentry
```

### ApiFire

A CLI tool for API testing and related developer workflows.

- Homebrew cask: `apifire`
- Install target: `apifire` command-line binary
- Best for: developers who want to install ApiFire on macOS through Homebrew

Install with:

```bash
brew install --cask rustx-labs/tap/apifire
```

Or after tapping the repository:

```bash
brew tap rustx-labs/tap
brew install --cask apifire
```

### Sky Monitor

A macOS sky monitoring application.

- Homebrew cask: `sky-monitor`
- Install target: `/Applications/sky-monitor.app`
- Best for: users who want sky monitoring as a native macOS app

Install with:

```bash
brew install --cask rustx-labs/tap/sky-monitor
```

Or after tapping the repository:

```bash
brew tap rustx-labs/tap
brew install --cask sky-monitor
```

## Brewfile Example

```ruby
tap "rustx-labs/tap"
cask "eye-sentry"
cask "apifire"
cask "sky-monitor"
```

## Notes

- If `/Applications/eye-sentry.app` or `/Applications/sky-monitor.app` already exists, the installer will replace it.
- `eye-sentry` and `sky-monitor` clear extended attributes during installation and launch automatically after install.
- `apifire` installs a CLI binary and clears extended attributes during installation.

## Documentation

For general Homebrew usage, see `brew help`, `man brew`, or [Homebrew's documentation](https://docs.brew.sh).

## License

Licensed under the [Apache License 2.0](LICENSE).

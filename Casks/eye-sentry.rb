cask "eye-sentry" do
  version "0.1.0"
  sha256 arm: "7ef9d81222f109a8135913276c966927cf675d23cc08914a6551bfd38fe7855c",
         intel: "06108e1cb1c817dc7a3ee1e0ee76780b892413cf64dfb1d2d6b2031825bba837"

  arch arm: "aarch64",
       intel: "x64"

  url "https://eye-sentry.netlify.app/downloads/eye-sentry_#{version}_#{arch}.dmg"
  name "Eye Sentry"
  desc "macOS eye care and focus assistant"
  homepage "https://eye-sentry.netlify.app/"

  app "eye-sentry.app"

  preflight do
    app_path = appdir/"eye-sentry.app"
    if app_path.exist?
      opoo "Existing app found at #{app_path}. Please remove it manually before installing."
    end
    downloaded_path = cask.download
    if downloaded_path&.exist?
      system_command "/usr/bin/xattr",
        args: ["-d", "com.apple.quarantine", downloaded_path.to_s]
    end
  end

  postflight do
    app_path = appdir/"eye-sentry.app"
    if app_path.exist?
      system_command "/usr/bin/xattr",
        args: ["-d", "com.apple.quarantine", app_path.to_s]
    end
    system_command "/usr/bin/open",
      args: ["-a", "eye-sentry"]
  end
end

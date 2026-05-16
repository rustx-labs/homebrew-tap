cask "eye-sentry" do
  version "0.1.13"
  sha256 arm: "3200b443ca4a8bb6233575c55a93315a582237dd1127ecf031b6d73c16b3f98a",
         intel: "f8e0a9e573c725ec8704aa2172fd3d7f97b5c85defd5e24f94ca9d67bb3f271b"

  arch arm: "aarch64-apple-darwin",
       intel: "x86_64-apple-darwin"

  url "https://rustx-labs.github.io/releases/eye-sentry/eye-sentry-v#{version}-#{arch}.dmg"
  name "Eye Sentry"
  desc "macOS eye care and focus assistant"
  homepage "https://eye-sentry.vercel.app/"

  app "eye-sentry.app"

  postflight do
    app_path = appdir/"eye-sentry.app"
    if app_path.exist?
      system_command "/usr/bin/xattr",
        args: ["-cr", app_path.to_s]
    end
    
    system_command "/usr/bin/open",
      args: ["-a", app_path.to_s]
  end
end

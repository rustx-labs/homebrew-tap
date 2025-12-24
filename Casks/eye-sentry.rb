cask "eye-sentry" do
  version "0.1.4"
  sha256 arm: "81f87c30b8f5731bde1d6870955497a278b3fce2af350d4d26ced7a71ac590fe",
         intel: "6dbc4c9864524067c2a0fba23a4317dbd7bf9b9e1f6e0ba24fdefbdd21e35456"

  arch arm: "aarch64",
       intel: "x64"

  url "https://eye-sentry.netlify.app/downloads/eye-sentry_#{version}_#{arch}.dmg"
  name "Eye Sentry"
  desc "macOS eye care and focus assistant"
  homepage "https://eye-sentry.netlify.app/"

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

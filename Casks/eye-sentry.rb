cask "eye-sentry" do
  version "0.1.7"
  sha256 arm: "9449d28a31906d95acd79d2b9c8cd4fb75e2b13f6c4c4c2132b4473ff8ea0946",
         intel: "2ae984fd3590f41f988057c4ddbb07913adc3cb3a24820a6688f1a370028b822"

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

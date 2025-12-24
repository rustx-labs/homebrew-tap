cask "eye-sentry" do
  version "0.1.4"
  sha256 arm: "38d4cf48c6e7794f2f15f150688396a22ffb5b4eac9639dd6490a9c770202171",
         intel: "ec4999f5b4141eb82d0042e5ed17e461fc059960f3be35f79475ed3fe1744956"

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

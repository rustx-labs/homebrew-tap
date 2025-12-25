cask "eye-sentry" do
  version "0.1.6"
  sha256 arm: "5cde9ffe14d58ff220bafaca85d7a0ab0d4bbd75ae88a8fc0b224cc61356b318",
         intel: "a6237f1b320551f2275ac59aca490c3aceeefbb1ad0086272ef2104bb7336c90"

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

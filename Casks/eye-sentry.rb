cask "eye-sentry" do
  version "0.1.10"
  sha256 arm: "34f739b035425d4dea22b70a82a955c50bc557a30771ffc4d542ad5f63b806ea",
         intel: "08f18f7f3d60b247af311ad073d715428f2375049c4b93e90f7f337a7b88ca65"

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

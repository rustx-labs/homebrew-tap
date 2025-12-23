cask "eye-sentry" do
  version "0.1.3"
  sha256 arm: "8d613640b727070fab4e417f2debc08c69ed778e43988da649f0f56002b0ec6e",
         intel: "884388e8a1a924a0d593b0ab50552942c2e5f36a5983fb9d05b9375c534c9619"

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
      opoo "An existing version of Eye Sentry was found. It will be removed before installing the new version."
      system_command "/bin/rm",
        args: ["-rf", app_path],
        sudo: !app_path.writable?
    end
    downloaded_path = cask.download
    if downloaded_path&.exist?
      system_command "/usr/bin/xattr",
        args: ["-cr", downloaded_path.to_s]
    end
  end

  postflight do
    app_path = appdir/"eye-sentry.app"
    if app_path.exist?
      system_command "/usr/bin/xattr",
        args: ["-cr", app_path.to_s]
    end
    system_command "/usr/bin/open",
      args: ["-a", "eye-sentry"]
  end
end

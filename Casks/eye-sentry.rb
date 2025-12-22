cask "eye-sentry" do
  version "0.1.1"
  sha256 arm: "b4a5e7a6ba786dc3cee3791faf71aa169f77543a8717535e1b80d4ef8e55d72d",
         intel: "0e986ee91356ddb5beb7f61132fd7f1c3b06fc511a218f20cecd1962c3c77aaf"

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

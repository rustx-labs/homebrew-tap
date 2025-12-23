cask "eye-sentry" do
  version "0.1.2"
  sha256 arm: "ff040b5cc4fe3b421770870bf41758c323c8ef33a2a29e7a8f674ae7b25f402b",
         intel: "d5f606b88399ead9db7cae8437849ffb98322f51113e61847735f4bb65874873"

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

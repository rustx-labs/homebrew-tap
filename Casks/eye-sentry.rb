cask "eye-sentry" do
  version "0.1.5"
  sha256 arm: "45bd53626e338373784520c430208d219483aaadca32d86418d6587604c03488",
         intel: "1ec528a92fc85712221c7f147d4f2e911d16838c316d17d26ffed695d6d19e38"

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

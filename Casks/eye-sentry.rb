cask "eye-sentry" do
  version "0.1.9"
  sha256 arm: "0229f0ae6186061c70deec4539ca1c1bf1cffdadb031006ba29a017d3eb6ad68",
         intel: "abaf22bc8ed32061d76848c83d37762020aa5bd3f98e37db00d5da0beb62c309"

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

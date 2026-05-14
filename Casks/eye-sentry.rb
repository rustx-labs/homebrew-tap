cask "eye-sentry" do
  version "0.1.11"
  sha256 arm: "7bc8d786d7c331f53c5c9ea54cff6a05f575aa5953062ee60a34e05accd6ed85",
         intel: "ce9b66e3273c4194c677813769a20d0ac76d65f992d93d7ce0b991e6c7da8b2f"

  arch arm: "aarch64-apple-darwin",
       intel: "x86_64-apple-darwin"

  url "https://rustx-labs.github.io/releases/eye-sentry/eye-sentry-v#{version}-#{arch}.dmg"
  name "Eye Sentry"
  desc "macOS eye care and focus assistant"
  homepage "https://eye-sentry.vercel.app/"

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

cask "eye-sentry" do
  version "0.1.14"
  sha256 arm: "1fafe9ac17589ff4497b4cfdd89ab08b3be58548c307a495cbe0cc30bcb8c50f",
         intel: "0e2585b34aeed75c191d0c8e51db47be48b81797aabb936818ad7b3221003242"

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

cask "eye-sentry" do
  version "0.1.16"
  sha256 arm: "f3a41d6065363cb4a55edbe78c7d033e9dba76daf10f45ad89c06d4c353b53b0",
         intel: "bbe97bd6a5dff277625472312b50b0042d7344f347e1a261fea4388a9ef716a4"

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

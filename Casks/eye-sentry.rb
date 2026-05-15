cask "eye-sentry" do
  version "0.1.12"
  sha256 arm: "86667c874cbb14cd1034bc7a99448f527b148d8e1cf2679a1aaab3f8967a735b",
         intel: "d58b382bebab6473745960817ca3f5d18b08511683102d159de1257d25675e2d"

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

cask "eye-sentry" do
  version "0.1.15"
  sha256 arm: "d79cb7301d5ba78cff592e7af16dc9307d361fea194e15799decd27e33aba402",
         intel: "87523ec980c903f2d165089d511a771e8b11d431cdc8bad561444f90ca2c827a"

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

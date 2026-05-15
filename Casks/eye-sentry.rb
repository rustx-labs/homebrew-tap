cask "eye-sentry" do
  version "0.1.11"
  sha256 arm: "5638d3c8fd2d28364384ecc32fbb391585c62f1eff2176fa13bbb82784815f8b",
         intel: "295ce6f26db67b9c0b029b377a8318bd96fdcfa4dcb41a33993f87d37bb52b33"

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

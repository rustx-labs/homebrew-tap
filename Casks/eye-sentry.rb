cask "eye-sentry" do
  version "0.1.0"
  sha256 arm: "5905b3385d08a272bec962656cb7d21a72cea42ec9e622ad8ddf65eb1496eb98",
         intel: "d9b01cb67db72e6f713a1dd94590d61119560db217590492c716e1755f6a84a8"

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
      system_command "/bin/rm",
        args: ["-rf", app_path],
        sudo: !app_path.writable?
    end
  end

  postflight do
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.quarantine", "#{appdir}/eye-sentry.app"]
    system_command "/usr/bin/open",
      args: ["-a", "eye-sentry"]
  end
end

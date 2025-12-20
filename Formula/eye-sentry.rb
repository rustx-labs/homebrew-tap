class EyeSentry < Formula
  desc "macOS eye care and focus assistant"
  homepage "https://eye-sentry.netlify.app/"
  version "0.1.0"
  
  on_arm do
    url "https://eye-sentry.netlify.app/downloads/eye-sentry_#{version}_aarch64.dmg"
    sha256 "5905b3385d08a272bec962656cb7d21a72cea42ec9e622ad8ddf65eb1496eb98"
  end
  
  on_intel do
    url "https://eye-sentry.netlify.app/downloads/eye-sentry_#{version}_x64.dmg"
    sha256 "d9b01cb67db72e6f713a1dd94590d61119560db217590492c716e1755f6a84a8"
  end

  depends_on macos: :monterey

  def install
    app_path = "eye-sentry.app"
    prefix.install app_path
  end

  postinstall do
    app_path = "#{prefix}/eye-sentry.app"
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.quarantine", app_path]
  end
end

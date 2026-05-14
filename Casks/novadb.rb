cask "novadb" do
  version "0.1.0"
  sha256 arm: "f513999242e87aaf3ec01db69663458cfb8c7243b7a1bd0227f7a45dabe1dcbf",
         intel: "28673113dcaeefb192b4cc5d9039ad7a815641fa536d8e54cb6f4ced29a57dd3"

  arch arm: "aarch64-apple-darwin",
       intel: "x86_64-apple-darwin"

  url "https://rustx-labs.github.io/releases/novadb/NovaDB-v#{version}-#{arch}.dmg"
  name "NovaDB"
  desc "Next-gen AI-native database client with intelligent agent"
  homepage "https://rustx-labs.github.io/"

  app "NovaDB.app"

  postflight do
    app_path = appdir/"NovaDB.app"
    if app_path.exist?
      system_command "/usr/bin/xattr",
        args: ["-cr", app_path.to_s]
    end

    system_command "/usr/bin/open",
      args: ["-a", app_path.to_s]
  end
end

cask "sky-monitor" do
  version "0.1.0"
  sha256 arm: "0d8b29f962a821dbda92d8ad1914c3c647cefcad13fea1a7e669388ac8f0fabc",
         intel: "b83807dd19ab91297548615d3d67033e24537f6aceb87d98258fa12f76030632"

  arch arm: "aarch64-apple-darwin",
       intel: "x86_64-apple-darwin"

  url "https://i3qqupmkg6cwhlzl.public.blob.vercel-storage.com/releases/v#{version}/sky-monitor-v#{version}-#{arch}.dmg"
  name "Sky Monitor"
  desc "macOS sky monitoring application"
  homepage "https://sky-monitor.vercel.app/"

  app "sky-monitor.app"

  postflight do
    app_path = appdir/"sky-monitor.app"
    if app_path.exist?
      system_command "/usr/bin/xattr",
        args: ["-cr", app_path.to_s]
    end

    system_command "/usr/bin/open",
      args: ["-a", app_path.to_s]
  end
end

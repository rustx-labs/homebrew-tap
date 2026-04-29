cask "sky-monitor" do
  version "0.1.0"
  sha256 arm: "394405f07ed10dee382b1032f6402d6722635ef25f5dde57277a2ee5eaf14951",
         intel: "d8622ad191ad9611b31bb3e97f2b88cffbc29da042930bc3de795b1c843fe46c"

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

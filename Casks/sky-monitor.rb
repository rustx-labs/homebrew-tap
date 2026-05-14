cask "sky-monitor" do
  version "0.1.0"
  sha256 arm: "9678b95fe62d852c546326ade31e32e114ef903f8ee12176843a8a3f09ed747f",
         intel: "1cedf31fb45e0149d8cecd9cc7cc5db9f287b429b4f81bf3b2243a6653426bfd"

  arch arm: "aarch64-apple-darwin",
       intel: "x86_64-apple-darwin"

  url "https://rustx-labs.github.io/releases/sky-monitor/sky-monitor-v#{version}-#{arch}.dmg"
  name "Sky Monitor"
  desc "Lightweight macOS menu-bar system monitor with real-time metrics"
  homepage "https://rustx-labs.github.io/"

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

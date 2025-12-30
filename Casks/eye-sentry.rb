cask "eye-sentry" do
  version "0.1.8"
  sha256 arm: "2dda977d2d8190f368717617c2952cb23ab315dc505c113e412f9cf5b3591395",
         intel: "10940d0ebddccc32a0e852fe6a67603a0329e2d18b335f04896631bdfbcca889"

  arch arm: "aarch64",
       intel: "x64"

  url "https://eye-sentry.netlify.app/downloads/eye-sentry_#{version}_#{arch}.dmg"
  name "Eye Sentry"
  desc "macOS eye care and focus assistant"
  homepage "https://eye-sentry.netlify.app/"

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

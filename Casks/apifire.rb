cask "apifire" do
  version "0.1.0"
  sha256 arm:   "6dac74533db13bdffb3f4b48cd3ecf90b11cf9e9fe9dfce848f386e840762306",
         intel: "0a982cbc2eebeab964041fc76a512d75dcfc112b87ecb2793680e8901d2b51d9"

  arch arm: "aarch64",
       intel: "x86_64"

  url "https://msjiarczdjxuxc5t.public.blob.vercel-storage.com/releases/v#{version}/apifire-v#{version}_#{arch}-apple-darwin.tar.gz"
  name "ApiFire"
  desc "API testing tool for macOS"
  homepage "https://apifire.vercel.app/"

  binary "apifire"

  postflight do
    binary_path = staged_path/"apifire"
    if binary_path.exist?
      system_command "/usr/bin/xattr",
        args: ["-cr", binary_path.to_s]
    end
  end
end

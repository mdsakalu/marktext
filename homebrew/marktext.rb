cask "marktext" do
  version "0.18.6-mdsakalu.1"

  on_arm do
    sha256 "PLACEHOLDER_ARM64_SHA256"
    url "https://github.com/mdsakalu/marktext/releases/download/v#{version}/marktext-mac-arm64-#{version}.zip",
        verified: "github.com/mdsakalu/marktext/"
  end
  on_intel do
    sha256 "PLACEHOLDER_X64_SHA256"
    url "https://github.com/mdsakalu/marktext/releases/download/v#{version}/marktext-mac-x64-#{version}.zip",
        verified: "github.com/mdsakalu/marktext/"
  end

  name "MarkText"
  desc "Simple and elegant markdown editor (mdsakalu fork)"
  homepage "https://github.com/mdsakalu/marktext"

  auto_updates true
  depends_on macos: ">= :monterey"

  app "marktext.app"

  # Remove quarantine attribute so app launches without Gatekeeper warning
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/marktext.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/marktext",
    "~/Library/Preferences/com.electron.marktext.plist",
    "~/Library/Saved Application State/com.electron.marktext.savedState",
  ]

  caveats <<~EOS
    MarkText is not notarized by Apple, but quarantine has been removed automatically.
    The app should launch without any Gatekeeper warnings.
  EOS
end

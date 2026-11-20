class Dani < Formula
  desc "Keyboard-first calendar for Google Calendar and macOS calendars"
  homepage "https://github.com/aleksandargosevski/dani"
  url "https://github.com/aleksandargosevski/dani/releases/download/v0.1.0/Dani-0.1.0.zip"
  sha256 "9dd6c3101103fc6df3c2b91eadb9af96f22f385e3193d91e3f4e5fa518746436"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    # Homebrew enters an archive's single top-level directory, which here is Dani.app itself.
    source = File.directory?("Contents") ? "." : "Dani.app"
    (prefix/"Dani.app").install Dir["#{source}/*"]
  end

  def caveats
    <<~EOS
      Make Dani visible to Spotlight, Raycast and the Dock:
        ln -sfn #{opt_prefix}/Dani.app /Applications/Dani.app

      The link keeps pointing at the newest version after brew upgrade.
      Shortcuts live in ~/.config/dani/keybindings.json.
    EOS
  end

  test do
    assert_path_exists prefix/"Dani.app/Contents/MacOS/Dani"
  end
end

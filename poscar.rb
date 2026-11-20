class Poscar < Formula
  desc "Fast, keyboard-first mail app for Gmail and IMAP"
  homepage "https://github.com/aleksandargosevski/poscar"
  url "https://github.com/aleksandargosevski/poscar/releases/download/v0.2.9/Poscar-0.2.9.zip"
  sha256 "b3d02d7470ffc7c94dafe9048ab3f14338f14a704eaf70b60b246fc479d86894"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    # Homebrew enters an archive's single top-level directory, which here is Poscar.app itself.
    source = File.directory?("Contents") ? "." : "Poscar.app"
    (prefix/"Poscar.app").install Dir["#{source}/*"]
  end

  def caveats
    <<~EOS
      Make Poscar visible to Spotlight, Raycast and the Dock:
        ln -sfn #{opt_prefix}/Poscar.app /Applications/Poscar.app

      The link keeps pointing at the newest version after brew upgrade.
      Gmail needs an App Password: https://myaccount.google.com/apppasswords
      Shortcuts live in ~/.config/poscar/keybindings.json.
    EOS
  end

  test do
    assert_path_exists prefix/"Poscar.app/Contents/MacOS/Poscar"
  end
end

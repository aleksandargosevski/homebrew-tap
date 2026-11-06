class Poscar < Formula
  desc "Fast, keyboard-first mail app for Gmail and IMAP"
  homepage "https://github.com/aleksandargosevski/poscar"
  url "https://github.com/aleksandargosevski/poscar/releases/download/v0.1.0/Poscar-0.1.0.zip"
  sha256 "10da85cd6175f8cb08ec98f2f6b9dc981b90f5e7e331733537ea0d55ae36705c"

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

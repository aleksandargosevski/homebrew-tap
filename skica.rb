class Skica < Formula
  desc "Fast, keyboard-first design app for macOS"
  homepage "https://github.com/aleksandargosevski/skica"
  url "https://github.com/aleksandargosevski/skica/releases/download/v0.2.0/Skica-0.2.0.zip"
  sha256 "1e362498e64666a8b1db1cf1d028b9fd8859cc0fc4d68790ea33e538523252fe"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    # Homebrew enters an archive's single top-level directory, which here is Skica.app itself.
    source = File.directory?("Contents") ? "." : "Skica.app"
    (prefix/"Skica.app").install Dir["#{source}/*"]
    bin.install_symlink prefix/"Skica.app/Contents/Helpers/skica"
  end

  def caveats
    <<~EOS
      Make Skica visible to Spotlight, Raycast and the Dock:
        ln -sfn #{opt_prefix}/Skica.app /Applications/Skica.app

      Open Skica once so Finder shows previews of .skica files.
      The skica command exports and converts files: skica --help
      Shortcuts live in ~/.config/skica/keybindings.json.
    EOS
  end

  test do
    system bin/"skica", "sample", testpath/"sample.skica"
    system bin/"skica", "export", testpath/"sample.skica", "-o", testpath/"out"
    assert_path_exists testpath/"out/iPhone.png"
  end
end

class Pismo < Formula
  desc "Switches the keyboard layout per app and per text field"
  homepage "https://github.com/aleksandargosevski/pismo"
  url "https://github.com/aleksandargosevski/pismo/releases/download/v0.0.1/Pismo-0.0.1.zip"
  sha256 "46a16c65c856e3b7489d9f3957cf1f14e7ad88dbd3fba64ab93ab72f0f59d79c"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    # Homebrew enters an archive's single top-level directory, which here is Pismo.app itself.
    source = File.directory?("Contents") ? "." : "Pismo.app"
    (prefix/"Pismo.app").install Dir["#{source}/*"]
  end

  service do
    run [opt_prefix/"Pismo.app/Contents/MacOS/Pismo"]
    keep_alive crashed: true
    process_type :interactive
  end

  def caveats
    <<~EOS
      Start Pismo now and at every login:
        brew services start pismo

      Then allow Pismo in System Settings → Privacy & Security → Accessibility.
      Rules live in ~/.config/pismo/rules.json.
    EOS
  end

  test do
    assert_path_exists prefix/"Pismo.app/Contents/MacOS/Pismo"
  end
end

class Skljoc < Formula
  desc "Screenshots with a floating preview and a quick annotation editor"
  homepage "https://github.com/aleksandargosevski/skljoc"
  url "https://github.com/aleksandargosevski/skljoc/releases/download/v0.1.2/Skljoc-0.1.2.zip"
  sha256 "b362a94de7b42976f1d7f357afb9bd9d9fe28dd4bff5650bef207335374164a4"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    # Homebrew enters an archive's single top-level directory, which here is Skljoc.app itself.
    source = File.directory?("Contents") ? "." : "Skljoc.app"
    (prefix/"Skljoc.app").install Dir["#{source}/*"]
  end

  service do
    run [opt_prefix/"Skljoc.app/Contents/MacOS/Skljoc"]
    keep_alive crashed: true
    process_type :interactive
  end

  def caveats
    <<~EOS
      Start Škljoc now and at every login:
        brew services start skljoc

      Then allow Škljoc in System Settings → Privacy & Security → Screen & System Audio Recording,
      and turn off the macOS screenshot shortcuts (Keyboard → Keyboard Shortcuts → Screenshots)
      so ⌘⇧3, ⌘⇧4 and ⌘⇧5 reach Škljoc.
    EOS
  end

  test do
    assert_path_exists prefix/"Skljoc.app/Contents/MacOS/Skljoc"
  end
end

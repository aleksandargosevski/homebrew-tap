class Skljoc < Formula
  desc "Screenshots with a floating preview and a quick annotation editor"
  homepage "https://github.com/aleksandargosevski/skljoc"
  url "https://github.com/aleksandargosevski/skljoc/releases/download/v0.1.1/Skljoc-0.1.1.zip"
  sha256 "cf6b8bf355c1a5666147d5a03fbfa66a6109c3a41c3e8875c3b1a1c19d0c652a"

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

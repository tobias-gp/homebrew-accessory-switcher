class AccessorySwitcher < Formula
  desc "Accessory Switcher"
  homepage "https://github.com/tobias-gp/accessory-switcher"
  
  url "https://github.com/tobias-gp/accessory-switcher/releases/download/v0.0.19/bundle.tar.gz"
  sha256 "1e739a0b0eedf105ed72903cf9d0194a9bd16a02656fc39b7eb173f28a22bf22"
  version "0.0.19"

  depends_on "python@3.9"
  depends_on "blueutil"

  def install
    # Install the service
    (lib/"AccessorySwitcher").install Dir["*"]

    # Create a script to start the service
    (bin/"AccessorySwitcher").write <<~EOS
      #!/bin/sh
      exec "#{HOMEBREW_PREFIX}/bin/python3" "#{opt_prefix}/lib/AccessorySwitcher/main.py" "$@"
    EOS
  end

  service do
    run opt_bin/"AccessorySwitcher"
    keep_alive true
  end

  test do
    system "#{bin}/AccessorySwitcher", "--help"
  end
end
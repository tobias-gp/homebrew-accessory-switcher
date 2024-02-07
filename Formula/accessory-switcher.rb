class AccessorySwitcher < Formula
  desc "Accessory Switcher"
  homepage "https://github.com/tobias-gp/accessory-switcher"
  
  url "https://github.com/tobias-gp/accessory-switcher/releases/download/v0.1.0/bundle.tar.gz"
  sha256 "3f4a5e4950ae46dfb0f6f406d50662fcb6fe537a123be535fa829b94bd148aee"
  version "0.1.0"

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
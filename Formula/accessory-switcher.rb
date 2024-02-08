class AccessorySwitcher < Formula
  desc "Accessory Switcher"
  homepage "https://github.com/tobias-gp/accessory-switcher"
  
  url "https://github.com/tobias-gp/accessory-switcher/releases/download/v0.1.0/bundle.tar.gz"
  sha256 "76021c2c5959355f1f40f08afcad07ab97e2af74cc7834c2701eb591d8296564"
  version "0.1.0"

  depends_on "blueutil"

  def install
    # Install the service
    (lib/"AccessorySwitcher").install Dir["*"]

    # Create a script to start the service
    (bin/"AccessorySwitcher").write <<~EOS
      #!/bin/sh
      ENV['PATH'] = "#{HOMEBREW_PREFIX}/bin:" + ENV['PATH']
      exec "python3" "#{opt_prefix}/lib/AccessorySwitcher/main.py" "$@"
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
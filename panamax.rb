require "formula"


class Panamax < Formula
  homepage "http://www.panamax.io"
  url "http://download.panamax.io/installer/panamax-0.6.0.tar.gz"
  sha1 "648544e32c3a1da8ab3284715c77e2e6427b3096"
  def install
    system "./configure", "--prefix=#{prefix}", "--var=#{var}/panamax"
    system "make", "install"
    resource("additional_files").stage { bin.install "panamaxcli-darwin" }
    mv bin/"panamaxcli-darwin",bin/"pmxcli"
  end

  def caveats
    "If upgrading the Panamax Installer, be sure to run 'panamax reinstall' to ensure compatibility with other Panamax components."
  end

  resource "additional_files" do
    url "http://download.panamax.io/panamaxcli/panamaxcli-darwin"
    sha1 "e01531c41cc9a2d24a2dafb0d130a358e34c885d"
  end

  test do
    assert File.exist?("#{prefix}/.panamax")
    assert File.exist?("#{var}/panamax")
    assert_match "#{version}", shell_output("#{prefix}/.panamax/panamax -v").strip
  end
end

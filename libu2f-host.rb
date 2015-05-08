class Libu2fHost < Formula
  homepage "https://developers.yubico.com/libu2f-host/"
  url "https://developers.yubico.com/libu2f-host/Releases/libu2f-host-0.0.4.tar.xz"
  version "0.0.4"
  sha256 "852231611bd5c526406b984ae3c92ce3423ffc7a0ef01f6a060a43b64725ead6"

  depends_on "json-c"
  depends_on "hidapi"

  def install
    ENV.append "LIBJSON_LIBS", "-L#{Formula["json-c"].opt_prefix}/lib -ljson-c"
    ENV.append "LIBJSON_CFLAGS", "-I#{Formula["json-c"].opt_prefix}/include/json-c/"
    ENV.append "HIDAPI_LIBS", "-L#{Formula["hidapi"].opt_prefix}/lib -lhidapi"
    ENV.append "HIDAPI_CFLAGS", "-I#{Formula["hidapi"].opt_prefix}/include/hidapi/"

    ENV.deparallelize

    system "./configure", "--disable-gtk-doc",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "u2f-host", "--version"
  end
end

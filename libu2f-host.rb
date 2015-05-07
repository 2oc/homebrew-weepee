class Libu2fHost < Formula
  homepage "https://developers.yubico.com/libu2f-host/"
  url "https://developers.yubico.com/libu2f-host/Releases/libu2f-host-0.0.4.tar.xz"
  version "0.0.4"
  sha256 "852231611bd5c526406b984ae3c92ce3423ffc7a0ef01f6a060a43b64725ead6"

  keg_only "Development library for u2f tools"

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
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test libu2f-host`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

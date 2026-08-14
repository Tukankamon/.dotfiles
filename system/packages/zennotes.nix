{pkgs, ...}: let
  # Obsidian alternative
  version = "2.3.0";
  icon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/ZenNotes/zennotes/main/apps/desktop/build/icon.png";
    hash = "sha256-dtxyOO4Y2C+vO/fAQxB3Rt6R2ETMM264+137uc1HtWg=";
  };
  zennotes = pkgs.appimageTools.wrapType2 {
    pname = "zennotes";
    version = version;
    src = pkgs.fetchurl {
      url = "https://github.com/ZenNotes/zennotes/releases/download/v${version}/ZenNotes-${version}-linux-x86_64.AppImage";
      hash = "sha256-IvFGK7n3KQVGETmt6hQUy+bZNTOCkfuwH8ifl4KTxxw=";
    };
    # Icon doesnt show
    extraInstallCommands = ''
      install -Dm644 ${pkgs.makeDesktopItem {
        name = "zennotes";
        desktopName = "ZenNotes";
        exec = "zennotes";
        icon = "zennotes";
        categories = ["Office" "TextEditor"];
      }}/share/applications/zennotes.desktop $out/share/applications/zennotes.desktop

      install -Dm644 ${icon} $out/share/icons/hicolor/512x512/apps/zennotes.png
    '';

    /*
     Shouldnt be necesary
    extraPkgs = p: with p; [
      libGL mesa
      xorg.libX11 xorg.libXcomposite xorg.libXcursor xorg.libXdamage
      xorg.libXext xorg.libXfixes xorg.libXi xorg.libXrandr
      xorg.libXrender xorg.libXtst xorg.libxcb xorg.libXScrnSaver
      wayland libxkbcommon
      gtk3 glib gdk-pixbuf pango cairo
      alsa-lib nss nspr dbus libsecret
      at-spi2-atk at-spi2-core cups expat fontconfig
    ];
    */
  };
in {
  environment.systemPackages = [zennotes];
}

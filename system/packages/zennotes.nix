{pkgs, ...}: let
  # Obsidian alternative
  version = "2.3.0";
  zennotes = pkgs.appimageTools.wrapType2 {
    pname = "zennotes";
    version = version;
    src = pkgs.fetchurl {
      url = "https://github.com/ZenNotes/zennotes/releases/download/v${version}/ZenNotes-${version}-linux-x86_64.AppImage";
      hash = "sha256-IvFGK7n3KQVGETmt6hQUy+bZNTOCkfuwH8ifl4KTxxw=";
    };

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

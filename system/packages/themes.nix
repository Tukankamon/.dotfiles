{pkgs, ...}: let
  cursorColor = "cyan";
in {
  nixpkgs.overlays = [
    (final: prev: {
      # From https://github.com/Tukankamon/Future-cursors
      # For the most up to date version import its flake in the github repo
      future = final.stdenvNoCC.mkDerivation {
        pname = "future-cursors";
        version = "2025-11-29";
        src = pkgs.fetchFromGitHub {
          owner = "Tukankamon";
          repo = "future-cursors";
          rev = "a180aa8fc48a42dff758b06c4a10aafacf1edd49";
          sha256 = "sha256-k3nD4FHKFNWwAbd4aI46HSldoqQABn0IyCcERy/b/N4=";
        };
        installPhase = ''
          runHook preInstall

          install -dm 755 $out/share/icons/future-cursors
          cp -rL dist/${cursorColor}/* $out/share/icons/future-cursors

          runHook postInstall
        '';
      };

      bsol-grub = final.fetchFromGitHub {
        #TODO put the bsol pkg in boot.nix here
      };
    })
  ];

  environment.variables = {
    # Must also be set in the config file of the DE
    XCURSOR_THEME = "future-cursors";
    XCURSOR_SIZE = "24";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };
  environment.etc."xdg/Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Nordic
  '';

  environment.systemPackages = with pkgs; [
    future
    #QT
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    nordic
  ];
}

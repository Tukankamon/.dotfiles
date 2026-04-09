{pkgs, ...}: {
  imports = [
    ./gnome.nix
    ./fish.nix
  ];

  # Last few programs that actually benefit from home manager

  services.gammastep = {
    # Gamma control for night light
    enable = true;
    package = pkgs.gammastep.override {withGeolocation = false;};

    # Not real coords. Just capital of spain
    latitude = 40.2;
    longitude = -3.7;
    tray = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = ["--cmd cd"]; # changes the cd to zoxide
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

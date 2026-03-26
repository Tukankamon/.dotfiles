{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./programs/kitty
    ./programs/fastfetch.nix
    ./programs/desktop
    ./programs/nvim
    ./programs/fish.nix
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package =
      inputs.futureCursors.packages."x86_64-linux".default.override
      {
        cursorColor = "cyan";
      };
    name = "future-cursors";
  };

  services.gammastep = {
    # Gamma control for night light
    enable = true;
    package = pkgs.gammastep.override {withGeolocation = false;};

    # Not real coords. Just capital of spain
    latitude = 40.2;
    longitude = -3.7;
    tray = true;
  };

  programs.git = {
    enable = true;
    settings = {
      # Change this accordingly
      init.defaultBranch = "main";
      user.name = "Tukankamon";
      # Github private email
      user.email = "wigle.flick228@passinbox.com"; # Proton alias
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = ["--cmd cd"]; # changes the cd to zoxide
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

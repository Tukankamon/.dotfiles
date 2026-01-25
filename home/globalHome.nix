{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./programs/kitty
    ./programs/fastfetch.nix
    ./desktopHomeBundle.nix
    ./programs/nvim.nix
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

  programs.bash = {
    enable = false;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd .."; # Shortcuts
    };
  };

  programs.git = {
    enable = true;
    settings = {
      # Change this accordingly
      init.defaultBranch = "main";
      user.name = "TuKankamon";
      # Github private email
      user.email = "198082906+Tukankamon@users.noreply.github.com";
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

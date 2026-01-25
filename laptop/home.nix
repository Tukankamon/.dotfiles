{pkgs, ...}: {
  imports = [
    ./../home/globalHome.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # List of home configurations, they dont interfere with eatch other
  # Choose from niri, gnome, hyprland or none
  desktopHome = ["niri" "gnome"];

  home.packages = with pkgs; [
    hello
  ];
  fonts.fontconfig.enable = true;

  home.file = {
  };

  home.sessionVariables = {
    #EDITOR = "vscodium";
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    #shellInit =  "fastfetch";

    shellAbbrs = {
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles#dwebble";
      hms = "home-manager switch --flake ~/.dotfiles#dwebble";

      nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";

      # Lists all installed packages (including dependencies
      nxls = "nix-store --query --requisites /run/current-system";
    };
  };
}

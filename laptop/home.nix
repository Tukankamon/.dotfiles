{...}: {
  imports = [
    ./../home/globalHome.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # List of home configurations, they dont interfere with eatch other
  # Choose from niri, gnome, hyprland or none
  desktopHome = ["niri" "gnome"];

  programs.fish = {
    enable = true;

    shellAbbrs = {
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles#dwebble";
      hms = "home-manager switch --flake ~/.dotfiles#dwebble";
    };
  };
}

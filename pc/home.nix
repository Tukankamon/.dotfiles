{...}: {
  imports = [
    ./../home/globalHome.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  desktopHome = ["niri" "gnome"];

  fonts.fontconfig.enable = true;

  programs.fish = {
    enable = true;
    shellAbbrs = {
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles#yamask";
      hms = "home-manager switch --flake ~/.dotfiles#yamask";
    };
  };
}

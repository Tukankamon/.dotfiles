{...}: {
  imports = [
    ./../home/global.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.fish = {
    enable = true;

    shellAbbrs = {
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles#dwebble";
      hms = "home-manager switch --flake ~/.dotfiles#dwebble";
    };
  };
}

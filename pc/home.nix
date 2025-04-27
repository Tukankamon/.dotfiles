{
  pkgs,
  ...
}:

{

  imports = [
    ./../konfig/home/global-home.nix
    ./../konfig/deskenv/desk-module.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.


  gnome.enable = false; # Dont forget to also disable it in pc-desktop.nix

  hypr.enable = true; # Same thing here

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
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles/pc";
      hms = "home-manager switch --flake ~/.dotfiles/pc";
      nxshell = "nix-shell ~/.dotfiles/development/shell.nix";

      nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
    };
  };
}

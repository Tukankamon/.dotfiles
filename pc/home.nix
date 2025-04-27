{
  pkgs,
  ...
}:

{

  imports = [
    ./../konfig/home/global-home.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.


  gnome.enable = true; 
  hypr.enable = false;

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

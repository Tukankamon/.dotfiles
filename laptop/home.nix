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

  gnome.enable = true; # Dont forget to also disable it in configuration.nix
  hypr.enable = false; # Same thing here

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
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles/laptop";
      hms = "home-manager switch --flake ~/.dotfiles/laptop";
      nxshell = "nix-shell ~/.dotfiles/development/shell.nix";

      nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";

      gitdo = "git add * && git commit -a -m automated-commit && git push origin main"; 
      #Maybe find a way to index e.g: automated-commit-1
    };
  };
}

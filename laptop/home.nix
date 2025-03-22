{ inputs, config, pkgs, lib, ... }:

{

  imports = [
    ./../konfig/home/global.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  gnome.enable = true;    #Dont forget to also disable it in configuration.nix
  hypr.enable = false;    #Same thing here

  home.packages = with pkgs; [
    pkgs.hello
  ];
  fonts.fontconfig.enable = true;

  home.file = {

  };

  home.sessionVariables = {
    #EDITOR = "vscodium";
  };
  
}

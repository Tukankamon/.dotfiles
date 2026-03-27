# UNUSED to try to move away from home manager
{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.modulesHome.stylix;
  # To enable grub and chromium theming you need the nixosModule not the home one
in {
  options.modulesHome.stylix = {
    enable = lib.mkEnableOption "Enable stylix config";

    /*
       Cant get this to work
    image = {
      type = lib.types.nullOr lib.types.path;
      default = null;
      example = ./path.jpg;
      description = "The image to be set with stylix.image";
    };
    */
  };

  imports = [inputs.stylix.homeModules.stylix];

  config = lib.mkIf cfg.enable {
    stylix = {
      #This is just half, the other is in the sys module
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml"; #Could change this
      polarity = "dark";
      autoEnable = false;
      image = ../other/images/roadwp.jpg;

      targets = {
        fuzzel.enable = false;
        swaylock.enable = false;
        fish.enable = false;

        #Track issue: https://github.com/nix-community/stylix/issues/1746
        #niri.enable = true;
      };
    };
  };
}

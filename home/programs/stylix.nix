{ lib, pkgs, config, ... }: let
  cfg = config.modulesHome.stylix;

in {
  options.modulesHome.stylix = {
    enable = lib.mkEnableOption "Enable stylix config";

    /* Cant get this to work
    image = {
      type = lib.types.nullOr lib.types.path;
      default = null;
      example = ./path.jpg;
      description = "The image to be set with stylix.image";
    };
    */
  };

  config = lib.mkIf cfg.enable {

    stylix = {
      #This is just half, the other is in the sys module
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml"; #Could change this
      polarity = "dark";
      autoEnable = false;
      image = ../../other/images/roadwp.jpg;

      opacity = {
        terminal = 0.9;
      };
      fonts = {
        sizes = {
          terminal = 12; # Default on foot is 10
        };

        monospace = {
          #package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
        };
        sansSerif = {};
        serif = {};
      };
     
      targets = {
        fuzzel.enable = true;
        foot.enable = true;
        swaylock.enable = true;
        fish.enable = true;

        #Track issue: https://github.com/nix-community/stylix/issues/1746
        #niri.enable = true;
      };
    };
  };
}

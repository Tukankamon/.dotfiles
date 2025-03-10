{ config, pkgs, lib, ... }:

{
options ={
  gnome.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "enables gnome desktop (need to also enable it in config)";
  };
};

config = lib.mkIf config.gnome.enable {

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      
      "org/gnome/shell" = {
        disable-user-extensions = false;
        /*enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell
        ];*/
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        #enabled = true;
        "blacklist"="@as []";
	      "blur-on-overview"=false;
	      "brightness"="1.0";
	      "customize"=true;
	      "enable-all"=true;
	      "opacity"="250";
	      "sigma"="59";
	      "blur"=true;
      };
 	"org/gnome/shell/extensions/tiling-shell" = {
                "enable-autotiling"=true;
	};

    };
  };
};
}

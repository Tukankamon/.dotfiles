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

      "org/gnome/desktop/background" = {
        picture-uri = "~/.dotfiles/konfig/images/roadwp.jpg";
      };
      
      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          #tiling-shell.extensionUuid
        ];

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

  "org/gnome/shell/app-switcher".current-workspace-only = true;

 	"org/gnome/shell/extensions/tiling-shell" = {
      "enable-autotiling"=true;
	};

  "org/gnome/desktop/wm/keybindings" = {
    close = ["<Alt>w"];

    switch-to-workspace-1 = ["<Alt>1"];
    switch-to-workspace-2 = ["<Alt>2"];
    switch-to-workspace-3 = ["<Alt>3"];
    switch-to-workspace-4 = ["<Alt>4"];

    move-to-workspace-1 = ["<Alt><Shift>1"];
    move-to-workspace-2 = ["<Alt><Shift>2"];
    move-to-workspace-3 = ["<Alt><Shift>3"];
    move-to-workspace-4 = ["<Alt><Shift>4"];
    };
      
    };
  };
};
}

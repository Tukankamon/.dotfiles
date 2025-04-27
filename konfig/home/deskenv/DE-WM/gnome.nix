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

  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tiling-shell
    gnomeExtensions.grand-theft-focus
  ];

  home.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    geary

  ];

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
          auto-move-windows.extensionUuid
          grand-theft-focus.extensionUuid
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
  "org/gnome/desktop/interface".enable-hot-corners =  false;

 	"org/gnome/shell/extensions/tiling-shell" = {
      "enable-autotiling"=true;
	};

  "org/gnome/shell/extensions/auto-move-windows" = {
    "application-list" = ["brave-browser.desktop:1"
                          "librewolf.desktop:2"
                          "obsidian.desktop:2"
                          "codium.desktop:3"
                          "discord.desktop:4"
                          "spotify.desktop:5"
                          "mullvad-browser.desktop:5"];
  };

  "org/gnome/mutter".dynamic-workspaces = false;
  "org/gnome/desktop/wm/preferences".num-workspaces = 5;
  "org/gnome/desktop/wm/keybindings" = {
    close = ["<Alt>p"];

    switch-to-workspace-1 = ["<Alt>1"];
    switch-to-workspace-2 = ["<Alt>2"];
    switch-to-workspace-3 = ["<Alt>3"];
    switch-to-workspace-4 = ["<Alt>4"];
    switch-to-workspace-5 = ["<Alt>5"];

    move-to-workspace-1 = ["<Alt><Shift>1"];
    move-to-workspace-2 = ["<Alt><Shift>2"];
    move-to-workspace-3 = ["<Alt><Shift>3"];
    move-to-workspace-4 = ["<Alt><Shift>4"];
    move-to-workspace-5 = ["<Alt><Shift>5"];
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.20;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      #accel-profile = "flat";
      speed = 0.25;
    };
      
    };
  };
};
}

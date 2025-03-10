{ config, pkgs, lib, ... }:     #Also need to enable it in configuration.nix

{
options ={
  hypr.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "enables hyprland (need to also enable it in config)";
  };
};

config = lib.mkIf config.hypr.enable {
  #wayland.windowManager.hyprland.enable = true;
  #settings = {};

    home.packages = [
    pkgs.waybar
    pkgs.rofi-wayland
  ];

};
}

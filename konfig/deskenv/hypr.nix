{ config, pkgs, lib, ... }:

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
};
}

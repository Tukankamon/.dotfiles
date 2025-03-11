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
  home.packages = [
      pkgs.waybar
      pkgs.rofi-wayland
      pkgs.dunst
      pkgs.libnotify
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {

    "$menu" = "rofi -show drun";
    "$terminal" = "kitty";
    "$mod" = "SUPER"; # Sets "Windows" key as main modifier (https://wiki.hyprland.org/Configuring/Keywords/)

    input = {
      kb_layout = "es";

      follow_mouse = 0; #Focuses where mouse is

      touchpad = {
        natural_scroll = false;
    };
    };

  misc = {
    force_default_wallpaper = 0; # Set to -1 to enable the anime mascot wallpapers
    disable_hyprland_logo = true;
  };
  
  general = {
    gaps_in = 5;
    gaps_out = 10;

    border_size = 2;

    # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
    "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";

    # Set to true enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false;

    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
    allow_tearing = false;

    layout = "dwindle";
  };

    "exec-once" = "waybar"; #autostart

    gestures = {
      workspace_swipe = false;
    };

    #Checkout bind flags: https://wiki.hyprland.org/0.18.0beta/Configuring/Binds/
    bind = [
      "$mod, Q, exec, $terminal"

      # Move focus with mod + arrow keys
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      #Workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
    ];

    bindr = [
      "$SUPER, SUPER_L, exec, $menu"
    ];

  };
};
}

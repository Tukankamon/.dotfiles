{ config, pkgs, lib, ... }:     #Also need to enable it in configuration.nix

{

imports = [ ./wayland/waybar/waybar.nix ];

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
      pkgs.swww
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {

    "$menu" = "rofi -show drun -show-icons";
    "$terminal" = "kitty";
    "$mod" = "SUPER"; # Sets "Windows" key as main modifier (https://wiki.hyprland.org/Configuring/Keywords/)

    input = {
      kb_layout = "es";

      follow_mouse = 1; #Focuses where mouse is

      touchpad = {
        natural_scroll = true;
    };
    };

  misc = {
    force_default_wallpaper = 0;
    disable_hyprland_logo = true;
  };

  master = {
    new_status = "master";
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
    monitor = "eDP-1, 1920x1080@144, 0x0, 1";

    "exec-once" = [ "waybar" "swww-daemon" ]; #autostart

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 2;
      workspace_swipe_min_fingers = true;

    };
    
    #Checkout bind flags: https://wiki.hyprland.org/0.18.0beta/Configuring/Binds/
    bind = [
      "$mod, Q, exec, $terminal"

      # Move focus with mod + arrow keys
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      "$mod SHIFT, left, swapwindow, l"
      "$mod SHIFT, right, swapwindow, r"
      "$mod SHIFT, up, swapwindow, u"
      "$mod SHIFT, down, swapwindow, d"


      #Workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"

      "$mod SHIFT, 1, movetoworkspace, 1"   #movetoworkspacesilent to not switch when moving
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      
    ];

    bindr = [
      "$SUPER, SUPER_L, exec, $menu"
    ];

    # Laptop multimedia keys for volume and LCD brightness
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      ];

    layerrule = [     #Supposed to blur waybar, doesnt work
      "blur, waybar"
      "ignorezero, waybar"
      "ignorealpha 0.5, waybar"
    ];
  };
};
}

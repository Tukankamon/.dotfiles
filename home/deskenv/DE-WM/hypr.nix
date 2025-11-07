{
    config,
    pkgs,
    lib,
    ...
}:
#Also need to enable it in configuration.nix
{
    imports = [./../wayland/waybar.nix];

    options = {
        hypr-home.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            example = true;
            description = "enables hyprland (need to also enable it in config)";
        };
    };

    config = lib.mkIf config.hypr-home.enable {
        home.packages = with pkgs; [
            pkgs.waybar
            pkgs.rofi-wayland
            pkgs.dunst
            pkgs.libnotify
            pkgs.swww
            hyprpaper
        ];

        /*
      services.hyprpaper.settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ home/aved/.dotfiles/other/images/roadwp.jpg ];

      wallpaper = [
        ", home/aved/.dotfiles/other/images/roadwp.jpg"
      ];
    };
    */

        wayland.windowManager.hyprland.enable = true;
        wayland.windowManager.hyprland.settings = {
            "$menu" = "rofi -show drun -show-icons";
            "$terminal" = "kitty";
            "$mod" = "SUPER"; # Sets "Windows" key as main modifier (https://wiki.hyprland.org/Configuring/Keywords/)

            input = {
                kb_layout = "es";

                follow_mouse = 1; # Focuses where mouse is

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

            "exec-once" = [
                "waybar"
                "swww-daemon"
                "./wayland/swww.sh"
            ]; # autostart

            gestures = {
                workspace_swipe = true;
                workspace_swipe_fingers = 3;
                workspace_swipe_min_fingers = true;
            };

            #Checkout bind flags: https://wiki.hyprland.org/0.18.0beta/Configuring/Binds/
            bind = [
                "$mod, Q, exec, $terminal"
                "ALT, P, killactive"

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
                "ALT, 1, workspace, 1"
                "ALT, 2, workspace, 2"
                "ALT, 3, workspace, 3"
                "ALT, 4, workspace, 4"
                "ALT, 5, workspace, 5"

                "ALT SHIFT, 1, movetoworkspace, 1" # movetoworkspacesilent to not switch when moving
                "ALT SHIFT, 2, movetoworkspace, 2"
                "ALT SHIFT, 3, movetoworkspace, 3"
                "ALT SHIFT, 4, movetoworkspace, 4"
                "ALT SHIFT, 5, movetoworkspace, 5"
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

            layerrule = [
                #Supposed to blur waybar, doesnt work
                "blur, waybar"
                "ignorezero, waybar"
                "ignorealpha 0.5, waybar"
            ];
        };
    };
}

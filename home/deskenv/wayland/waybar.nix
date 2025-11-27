{...}:
#From Eli's dotfiles (https://github.com/elifouts/Dotfiles/tree/main)
{
    imports = [./waybar-css.nix];

    programs.waybar.enable = true;
    programs.waybar.settings = {
        mainBar = {
            "layer" = "top";
            "position" = "top";
            "reload_style_on_change" = true;
            "modules-left" = [
                #"custom/notification"
                "clock"
                "tray"
            ];
            "modules-center" = ["niri/workspaces"];
            "modules-right" = [
                "pulseaudio"
                "cpu"
                "memory"
                "temperature"
                "bluetooth"
                "network"
                "battery"
            ];

            #Change to hyprland if needed
            "niri/workspaces" = {
                "format" = "{icon}";
                "format-icons" = {
                    "active" = ""; # snowflake
                    "default" = "◯";
                    #"empty" = "◯";
                };
                "persistent-workspaces" = {
                    "*" = [
                        1
                        2
                        3
                    ];
                };
            };
            /*
            "custom/notification" = {
                "tooltip" = false;
                "format" = "";
                "on-click" = "swaync-client -t -sw";
                "escape" = true;
            };
            */
            "clock" = {
                "format" = "{:%d/%m %H:%M} ";
                "interval" = 1;
                "tooltip-format" = "<tt>{calendar}</tt>";
                "calendar" = {
                    "format" = {
                        "today" = "<span color='#fAfBfC'><b>{}</b></span>";
                    };
                };
                "actions" = {
                    "on-click-right" = "shift_down";
                    "on-click" = "shift_up";
                };
            };
            "network" = {
                "format-wifi" = " ";
                "format-ethernet" = " ";
                "format-disconnected" = " ";
                "tooltip-format-disconnected" = "Error";
                "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
                "tooltip-format-ethernet" = "{ifname} 🖧 ";
                "on-click" = "kitty nmtui";
            };
            "bluetooth" = {
                "format-on" = "󰂯";
                "format-off" = "BT-off";
                "format-disabled" = "󰂲";
                "format-connected-battery" = "{device_battery_percentage}% 󰂯";
                "format-alt" = "{device_alias} 󰂯";
                "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
                "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
                "tooltip-format-enumerate-connected" = "{device_alias}\n{device_address}";
                "tooltip-format-enumerate-connected-battery" = "{device_alias}\n{device_address}\n{device_battery_percentage}%";
                "on-click-right" = "blueman-manager"; };

                "battery" = {
                "interval" = 30;
                "states" = {
                    "good" = 95;
                    "warning" = 30;
                    "critical" = 20;
                };
                "format" = "{capacity}% {icon}";
                "format-charging" = "{capacity}% 󰂄";
                "format-plugged" = "{capacity}% 󰂄 ";
                "format-alt" = "{time} {icon}";
                "format-icons" = [
                    ""
                    "󰁼"
                    "󰁾"
                    "󰂀"
                    "󰂂"
                    "󰁹"
                ];
            };

            "pulseaudio" = { #TODO icons and shi
                "format" = "vol:{volume}% ";
                "format-bluetooth" = "blue-vol:{volume}%";
                "format-muted" = "muted";

                "on-click" = "pavucontrol";
            };

            "cpu" = {
                "format" = "{usage:>2}% 󰻠";
                "tooltip" = true;
            };
            "memory" = {
                "interval" = 30;
                "format" = "{used:0.1f}%  ";
            };
            "temperature" = {
                "critical-threshold" = 80;
                "format" = "{temperatureC}ºC  ";
            };
            "tray" = {
                "icon-size" = 14;
                "spacing" = 10;
            };
        };
    };
}

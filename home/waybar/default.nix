{...}:
#From Eli's dotfiles (https://github.com/elifouts/Dotfiles/tree/main)
{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar.css;
    settings = {
      mainBar = {
        "layer" = "top";
        "position" = "top";
        "reload_style_on_change" = true;
        "modules-left" = [
          "custom/power"
          "clock"
          "niri/language"
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

        "custom/power" = {
          "format" = " ⏻ ";
          "on-click" = "wlogout";
        };

        "clock" = {
          "format" = "{:%d/%b %H:%M} ";
          "interval" = 1;
          "tooltip-format" = "<tt>{calendar}</tt>";
          "calendar" = {
            "format" = {
              "today" = "<span color='#fAfBfC'><b>{}</b></span>";
            };
          };

          #"on-click" = "${pkgs.gnome-calendar}/bin/gnome-calendar";

          "actions" = {
            #"on-click-right" = "shift_down";
            #"on-click" = "shift_up";
          };
        };

        # Not working #BROKEN
        "niri/language" = {
          "tooltip" = "Alt + Space to swap";
          "format" = "{long} ⌨️";
          "format-es" = "es";
          "format-gr" = "gr";
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
          "on-click-right" = "blueman-manager";
        };

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

        "pulseaudio" = {
          "format" = "{volume}%🔊 ";
          "format-bluetooth" = "{volume}%󰗾";
          "format-muted" = "🔇";

          "on-click" = "pavucontrol";
        };

        "cpu" = {
          "format" = "{usage:>2}% ";
          "tooltip" = true;
        };
        "memory" = {
          "interval" = 20;
          "format" = "{used:0.1f}GB ";
          "tooltip" = true;
          "tooltip-format" = "Ram usage in gigabytes";
        };
        "temperature" = {
          "critical-threshold" = 80;
          "format" = "{temperatureC}ºC ";
        };
        "tray" = {
          "icon-size" = 14;
          "spacing" = 10;
        };
      };
    };
  };
}

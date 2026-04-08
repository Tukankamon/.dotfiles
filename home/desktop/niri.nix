# Niri.nix HOME
{
  config,
  lib,
  ...
}: {
  imports = [
    ../waybar
    #../stylix.nix
  ];

  options = {
    niriHome = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enables the customisation of niri plus some packages";
    };
  };

  config = lib.mkIf config.niriHome {
    # managed by dotter
    #xdg.configFile."niri/config.kdl".source = ./niri.kdl;

    #modulesHome.stylix.enable = true;

    # Programs that are targeted with stylix need to be enabled here (or on nixos module in that case) to be affected by HM stylix
    services.udiskie = {
      # Needs udisks2 and gvfs services (they are in the other niri.nix)
      enable = true;
      automount = true;
      settings = {
        tray = true;
        program_options.file_manager = "nautilus"; # Fixes xdg-open error
      };
    };

    programs.wlogout = {
      # No stylix support yet
      enable = true;
      layout = [
        # Logout option missing
        {
          label = "lock";
          action = "swaylock";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "suspend";
          action = "swaylock --daemonize && systemctl suspend";
          text = "Suspend";
          keybind = "u";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
      ];
    };
  };
}

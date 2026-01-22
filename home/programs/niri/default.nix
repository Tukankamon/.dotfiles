# Niri.nix HOME
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../waybar
    ./../foot
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
    xdg.configFile."niri/config.kdl".source = ./niri.kdl;

    home.packages = with pkgs; [
      # Installed on system level
    ];

    # Programs that are targeted with stylix need to be enabled here (or on nixos module in that case) to be affected by HM stylix
    programs.fuzzel = {
      # App launcher
      enable = true;
      settings = {
        main = {
          dpi-aware = "yes";
          minimal-lines = true;
          font = lib.mkForce "DejaVu Sans:size=20"; # Might interfere with stylix font
        };
      };
    };

    services.udiskie = {
      # Needs udisks2 and gvfs services (they are in the other niri.nix)
      enable = true;
      automount = false;
      settings = {
        tray = true;
        program_options.file_manager = "nautilus"; # Fixes xdg-open error
      };
    };

    programs.swaylock.enable = true;
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

    stylix = {
      #This is just half, the other is in the sys module
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml"; #Could change this
      image = ./../../../other/images/roadwp.jpg;
      polarity = "dark";
      autoEnable = false;

      opacity = {
        terminal = 0.9;
      };
      fonts = {
        sizes = {
          terminal = 12; # Default on foot is 10
        };

        monospace = {
          #package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
        };
        sansSerif = {};
        serif = {};
      };
     
      targets = {
        fuzzel.enable = true;
        foot.enable = true;
        swaylock.enable = true;
        fish.enable = true;
        #niri.enable = true; #Track issue: https://github.com/nix-community/stylix/issues/1746
      };
    };
  };
}

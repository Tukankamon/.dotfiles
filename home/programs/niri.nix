# Niri.nix HOME
{
    config,
    pkgs,
    lib,
    inputs,
    ...
}: {
    imports = [./../programs/waybar.nix];

    options = {
        niriHome = lib.mkOption {
            type = lib.types.bool;
            default = false;
            example = true;
            description = "Enables the customisation of niri plus some packages";
        };
    };

    config = lib.mkIf config.niriHome {
        xdg.configFile."niri/config.kdl".source = ./configs/niri.kdl;

        home.packages = with pkgs; [
            waybar
            alacritty
            fuzzel
            swaybg
            swaylock
            mako #notification daemon
            xwayland-satellite # Support for Xwayland (doesnt quite work)
            wlogout # Logout menu, not update in over a year so be careful
            gnome-system-monitor # I like it
            gnome-disk-utility # Very nice gui for disks
            udiskie # Auto mount (GUI), if not usb needs to be mounted manually
            nautilus # File manager
        ];

        # Programs that are targeted with stylix need to be enabled here (or on nixos module in that case) to be affected by HM stylix
        programs.alacritty.enable = true; #Just in case, this is the default terminal
        programs.fuzzel = {
            # App launcher
            enable = true;
            settings = {
                main = {
                    dpi-aware = "no";
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

        programs.foot.enable = true;
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
            image = ./../../other/images/roadwp.jpg;
            polarity = "dark";
            autoEnable = false;
            fonts.sizes = {
                terminal = 10;
            };

            opacity = {
                terminal = 0.9;
            };

            targets = {
                /*
        nvf.enable = false;
        vim.enable = false;
        */

                fuzzel.enable = true;
                foot.enable = true;
                alacritty.enable = true;
                swaylock.enable = true;
                fish.enable = true;
                #niri.enable = true; #Track issue: https://github.com/nix-community/stylix/issues/1746
            };
        };
    };
}

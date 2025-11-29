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
        niriHome.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            example = true;
            description = "Enables the customisation of niri plus some packages";
        };
    };

    config = lib.mkIf config.niriHome.enable {
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
        ];

        # Programs that are targeted with stylix need to be enabled here (or on nixos module in that case) to be affected by HM stylix
        programs.alacritty.enable = true; #Just in case, this is the default terminal
        programs.fuzzel = {
            # App launcher
            enable = true;
            settings = {
                main = {
                    dpi-aware = "no";
                };
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
                    action = "systemctl suspend";
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

        /*
       #This would mess with my config over there
    programs.obsidian.enable = true;

    nixpkgs.config.allowUnfreePredicate = pkg: # This is set twice, once done in global.nix
        builtins.elem (pkgs.lib.getName pkg) [
            "obsidian"
        ];
    */

        stylix = {
            #This is just half, the other is in the home module
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

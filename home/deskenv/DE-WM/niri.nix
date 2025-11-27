{
    config,
    pkgs,
    lib,
    inputs,
    ...
}:

{
    imports = [./../wayland/waybar.nix];

    options = {
        niriHome.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            example = true;
            description = "Enables the customisation of niri";
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
        ];

        programs.alacritty.enable = true; #Just in case, this is the default terminal
        programs.fuzzel.enable = true; #Same thing, JIC

        programs.foot.settings = { #Trying to remove window decorations
            enable = true;
            csd.prefered = "none";
        };

        stylix = { #This is just half, the other is in the home module
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml"; #Could change this
            image = ./../../../other/images/roadwp.jpg;
            autoEnable = false;
            targets = {
                fuzzel.enable = true;
                foot.enable = true;
                alacritty.enable = true;
                swaylock.enable = true;
                #niri.enable = true; #Track issue: https://github.com/nix-community/stylix/issues/1746
            };
        };

    };
}

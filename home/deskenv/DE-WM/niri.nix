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
            alacritty
            fuzzel
            swaybg
            swaylock
        ];

        programs.alacritty.enable = true; #Just in case, this is the default terminal
        programs.fuzzel.enable = true; #Same thing, JIC

/*
        stylix = {
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml"; #Could change this
            image = ./../other/images/roadwp.jpg;
            autoEnable = false;
            targets = {
                #fuzzel.enable = true;
                foot.enable = true;
                alacritty.enable = true;
                #niri.enable = true;
            };
        };
        */


    };
}

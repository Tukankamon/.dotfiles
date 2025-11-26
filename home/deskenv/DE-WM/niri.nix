{
    config,
    pkgs,
    lib,
    ...
}:

{
    imports = [./../wayland/waybar.nix];

    options = {
        niri-home.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            example = true;
            description = "Enables the customisation of niri and noctalia shell (if installed)";
        };
    };

    config = lib.mkIf config.niri-home.enable {
        xdg.configFile."niri/config.kdl".source = ./configs/niri.kdl;

        home.packages = with pkgs; [
            alacritty
            fuzzel
            swaybg
        ];

        programs.alacritty.enable = true; #Just in case, this is the default terminal
        programs.fuzzel.enable = true; #Same thing, JIC
    };
}

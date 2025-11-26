{
    config,
    pkgs,
    lib,
    ...
};

{
    imports = [];

    options = {
        niri-home.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            example = true;
            description = "Enables the customisation of niri and noctalia shell (if installed)"
        };
    };

    config = lib.mkIf config.niri-home.enable {
        xdg.configFile."niri/config.kdl".source = ./configs/niri.kdl;

    };
}

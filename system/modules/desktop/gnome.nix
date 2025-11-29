{
    pkgs,
    lib,
    config,
    inputs,
    ...
}:
# INputs bc stylix will break even when not using it
{
    options = {
        gnome = lib.mkEnableOption {
            type = lib.types.bool;
            default = true;
            description = "Aux option to enable gnome, use the desktop option to actually set it";
        };
    };

    config = lib.mkIf config.gnome {
        # Enable the GNOME Desktop Environment.
        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;
    };
}

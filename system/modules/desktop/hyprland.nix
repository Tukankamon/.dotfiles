{
    pkgs,
    lib,
    config,
    ...
}: {
    options = {
        hyprland = lib.mkEnableOption {
            type = lib.types.bool;
            default = false;
            description = "Aux option to enable hyprland, use the desktop option to actually set it";
        };
    };

    config = lib.mkIf config.hyprland {
        programs.hyprland = {
            enable = false;
            xwayland.enable = true;
            #package = inputs.hyprland.packages.${pkgs.system}.hyprland;  #Only when using the flake
        };

        xdg.portal = {
            #For hyprland
            enable = true;
            extraPortals = [pkgs.xdg-desktop-portal-gtk];
        };
    };
}

{
    pkgs,
    config,
    lib,
    ...
}:
#There is also a home manager for this to manage them
{
    options = {
        desktop = lib.mkOption {
            # Use lib.types.nullOr to allow either null OR the following type.
            # Use lib.types.enum to restrict the string values to a specific list.
            type = lib.types.nullOr (lib.types.enum ["gnome" "hyprland" "niri"]); #I think u can do 2 environments at the same time

            default = "gnome";

            description = ''Selects the DE/WM, set to null for no graphical interface. Will probably crash tho'';

            example = "niri";
        };
    };

    imports = [
        ./desktop/gnome.nix
        ./desktop/hyprland.nix
        ./desktop/niri.nix
    ];

    config = {
        environment.sessionVariables.NIXOS_OZONE_WL = "1";
        #Forces wayland

        gnome = lib.mkIf (config.desktop == "gnome") true;
        hyprland = lib.mkIf (config.desktop == "hyprland") true;
        niriwm = lib.mkIf (config.desktop == "niri") true;
    };
}
# --- PLEASE READ ---
# When trying to install hyprland/Gnome these are the only things to change
# (Unless changing things in the flake)


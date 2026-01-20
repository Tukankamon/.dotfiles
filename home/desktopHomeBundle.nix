{
  config,
  lib,
  ...
}: {
  options = {
    desktopHome = lib.mkOption {
      # Use lib.types.nullOr to allow either null OR the following type.
      # Use lib.types.enum to restrict the string values to a specific list.
      type = lib.types.nullOr (lib.types.enum ["gnome" "hyprland" "niri"]); #I think u can do 2 environments at the same time

      default = "niri";

      description = ''Selects the DE/WM home manager config'';

      example = "gnome";
    };
  };
  imports = [
    ./programs/gnome.nix
    ./programs/hypr.nix
    ./programs/niri
    #../system/modules/desktopBundle.nix # To be able to set options depending on it
  ];

  config = {
    gnomeHome = lib.mkIf (config.desktopHome == "gnome") true;
    hyprHome = lib.mkIf (config.desktopHome == "hyprland") true;
    niriHome = lib.mkIf (config.desktopHome == "niri") true;
  };
}

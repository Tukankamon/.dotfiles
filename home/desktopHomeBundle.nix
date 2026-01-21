{
  config,
  lib,
  ...
}: {
  options = {
    desktopHome = lib.mkOption {
      # Use lib.types.enum to restrict the string values to a specific list.
      #I think u can do 2 environments at the same time
      type = lib.types.listOf (lib.types.enum ["gnome" "hyprland" "niri" "none"]);


      default = [ "niri" ]; # Value is a list, not a string

      description = ''Selects the DE/WM home manager config'';

      example = [ "gnome" ];
    };
  };
  imports = [
    ./programs/gnome.nix
    ./programs/hypr.nix
    ./programs/niri
    #../system/modules/desktopBundle.nix # To be able to set options depending on it
  ];

  config = {
    gnomeHome = lib.mkIf (lib.elem "gnome" config.desktopHome) true;
    hyprHome  = lib.mkIf (lib.elem "hyprland" config.desktopHome) true;
    niriHome  = lib.mkIf (lib.elem "niri" config.desktopHome) true;
  };
}

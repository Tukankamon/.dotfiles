{
  lib,
  config,
  ...
}: {
  options.modules.specialisation.enable = lib.mkEnableOption "System specialisation";

  config = lib.mkIf config.modules.specialisation.enable {
    specialisation = {
      gnome.configuration = {
        # Builds a second boot entry for gnome
        desktop = "gnome";
      };
    };

    # ONly applies to the default system
    desktop = lib.mkIf (config.specialisation != {}) "niri";
  };
}

# This is here instead of in the packages folder since it is an enable/disable option
{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.ardour.enable = lib.mkEnableOption "Enable ardour pkg and its plugins";

  config = lib.mkIf config.modules.ardour.enable {
    environment.systemPackages = with pkgs; [
      ardour

      #plugins
      mda_lv2
      calf
      x42-avldrums
    ];
  };
}

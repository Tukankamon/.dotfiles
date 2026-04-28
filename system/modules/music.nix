# This is here instead of in the packages folder since it is an enable/disable option
{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.music;
in {
  options.modules.music = {
    enable = lib.mkEnableOption "Enable music players, chat rooms and others";
    ardour.enable = lib.mkEnableOption "Enable ardour pkg and its plugins";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        nicotine-plus # P2P music sharing, different from torrents
        strawberry # FOOBAR2000-like music player
      ]
      ++ lib.optionals cfg.ardour.enable [
        ardour

        #plugins
        mda_lv2
        calf
        x42-avldrums
      ];
  };
}

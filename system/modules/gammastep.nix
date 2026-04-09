{
  pkgs,
  config,
  lib,
  ...
}: let
  newGamma = pkgs.gammastep.override {withGeolocation = false;};
in {
  options.modules.gammastep.enable = lib.mkEnableOption "Enable gammastep option";

  # Tray icon is not set so it is just a default square
  config = lib.mkIf config.modules.gammastep.enable {
    systemd.user.services.gammastep = {
      description = "Gammastep display colour temperature adjustment";
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = "${newGamma}/bin/gammastep-indicator -l 40.2:-3.7 -t 6500:3500";
        Restart = "always";
        RestartSec = 5;
      };
    };

    # restart if changed should be true but just in case
    system.userActivationScripts.startGammastep = {
      text = ''
        ${pkgs.systemd}/bin/systemctl --user start gammastep.service || true
      '';
      deps = [];
    };
  };
}

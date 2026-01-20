{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.autofirma = {
    enable = lib.mkEnableOption "Enable or disable autofirma (spanish government stuff)";
  };

  config = lib.mkIf config.modules.autofirma.enable {
    programs.autofirma = {
      enable = false; # Problems on laptop
      firefoxIntegration.enable = true;
    };

    programs.firefox = {
      enable = false;
      policies.SecurityDevices = {
        "OpenSC PKCS#11" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
        "DNIeRemote" = "${config.programs.dnieremote.finalPackage}/lib/libdnieremotepkcs11.so";
      };
    };
  };
}

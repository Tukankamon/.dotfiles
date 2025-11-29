{
    pkgs,
    config,
    ...
}: {
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
}

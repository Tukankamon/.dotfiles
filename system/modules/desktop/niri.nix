{
    pkgs,
    lib,
    config,
    inputs,
    ...
}: {
    options = {
        niri = lib.mkEnableOption {
            type = lib.types.bool;
            default = false;
            description = "Enable de niri scrolling WM";
        };
    };

    config = lib.mkIf config.niri {
        environment.sessionVariables.NIXOS_OZONE_WL = "1";
        programs.niri.enable = true;

        #For noctalia shell you need it in a flake
        environment.systemPackages = with pkgs; [
            #Installed in the user
        ];

        services = {
            udisks2.enable = true; # Semi automounting usbs, use udiske (home-manager) for GUI and notis
            gvfs.enable = true; # This aswell, polkit needs to be enabled aswell
        };
        stylix = {
            # This is just half, the other is in the home module
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml"; #Could change this
            image = ./../../../other/images/roadwp.jpg;
            autoEnable = false;
            targets = {
                grub.enable = false;
                chromium.enable = true;
            };
        };
    };
}

{pkgs, lib, config, inputs, ...}:
{
    options = {
        niriwm = lib.mkEnableOption {
            type = lib.types.bool;
            default = false;
            description = "Enable de niri scrolling WM";

        };
    };

    config = lib.mkIf config.niriwm {
        environment.sessionVariables.NIXOS_OZONE_WL = "1";
        programs.niri.enable = true;

        #For noctalia shell you need it in a flake
        environment.systemPackages = with pkgs; [
            #Installed in the user
        ];

        stylix = { # This is just half, the other is in the home module
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

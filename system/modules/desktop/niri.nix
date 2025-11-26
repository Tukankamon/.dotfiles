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
            inputs.noctalia.packages.x86_64-linux.default
            waybar
        ];

    };
}

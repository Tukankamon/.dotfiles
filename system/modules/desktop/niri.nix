{pkgs, lib, config, ...}: #TODO
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

        programs.alacritty.enable = true; #Just in case, this is the default terminal
        programs.fuzzel.enable = trueM #Same thing, JIC
    };
}

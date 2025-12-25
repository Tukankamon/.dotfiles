{
    config,
    lib,
    pkgs,
    ...
}: {
    options = {
        grub-boot.enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            example = false;
            description = "sets the boot config for the pc";
        };
    };

    config = lib.mkIf config.grub-boot.enable {
        environment.systemPackages = with pkgs; [
            vulkan-tools
            vulkan-loader
        ]; # Had issues with wayland gamescope

        environment.variables = {
            ROC_ENABLE_PRE_VEGA = "1";
        };

        hardware.graphics.enable = true;
        boot = {
            initrd.kernelModules = ["amdgpu"]; # davinci-resolve  Might not be able to use amdgpu-pro bc the kernel is not up to date enough

            loader = {
                systemd-boot.enable = false; # Change when using / not using grub

                efi.canTouchEfiVariables = true;

                timeout = 1;
                grub = {
                    enable = true;
                    devices = ["nodev"];
                    efiSupport = true;
                    useOSProber = true; # To detect other operating systems
                    splashImage = ./../../other/images/matrix-options.png;
                };
            };

            kernelModules = [
                "snd-seq"
                "snd-rawmidi"
            ];
            kernelParams = ["kvm.enable_virt_at_load=0"]; # For virtualbox

            plymouth = {
                enable = false;
                theme = "spinfinity";
            };
        };

        security.polkit.enable = true; # I think this is also needed
    };
}

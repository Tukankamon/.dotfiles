{
  config,
  pkgs,
  lib,
  ...
}: {
  # Many of these options will try to get davinci-resolve to work without any luck
  # Embed this into a bigger modules.hardware option if needed
  options.modules.amd.enable = lib.mkEnableOption "AMD GPU configs";

  config = lib.mkIf config.modules.amd.enable {
    environment.systemPackages = with pkgs; [
      #vulkan-tools
      #vulkan-loader
    ]; # Had issues with wayland gamescope

    environment.variables = {
      ROC_ENABLE_PRE_VEGA = "1";
    };

    # For davinci-resolve, I think amdgpu is the default anyways
    #Might not be able to use amdgpu-pro bc the kernel is not up to date enough
    boot.initrd.kernelModules = ["amdgpu"];

    #systemd.packages = with pkgs; [ lact ];
    #systemd.services.lactd.wantedBy = ["multi-user.target"];
    hardware = {
      #For davinci resolve
      enableRedistributableFirmware = true; # ChatGPT recommendation
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
        ];
      };
    };
  };
}

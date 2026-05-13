{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.zathura = {
    enable = lib.mkEnableOption "Enable the Zathura PDF viewer";

    isDefault = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Set Zathura as the default PDF viewer";
    };
  };

  config = lib.mkIf config.modules.zathura.enable {
    environment.systemPackages = with pkgs; [zathura];

    xdg.mime = {
      enable = true;
      defaultApplications = lib.mkIf config.modules.zathura.isDefault {
        "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
      };
    };
  };
}

{ inputs, config, pkgs, lib, ... }:

{

  options ={
  pc-boot.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "sets the boot config for the pc";
  };
};

config = lib.mkIf config.gnome.enable {

  imports = [ ./../../pc/hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "spinfinity";
  };
  };
};


  options ={
  laptop-boot.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "sets the boot config for the pc";
  };
};

config = lib.mkIf config.gnome.enable {

  imports = [ ./../../laptop/hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "spinfinity";
  };
  };
};

}
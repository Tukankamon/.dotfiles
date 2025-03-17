{ inputs, config, pkgs, lib, ... }:

{
imports = [ ./hardware-configuration.nix ];

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
}
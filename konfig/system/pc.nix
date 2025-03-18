{ inputs, pkgs, configuration, ... }:

{
  imports = [
    ./boot/pc-boot.nix
    ./desktop/pc-desktop.nix
  ]
}
{ inputs, pkgs, configuration, ... }:

{
  imports = [
    ./boot/laptop-boot.nix
    ./desktop/laptop-desktop.nix
  ];
}
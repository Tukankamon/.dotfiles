{ inputs, config, pkgs, lib, ... }:

{
  imports = [ ./laptop-boot.nix ./pc-boot.nix];
}
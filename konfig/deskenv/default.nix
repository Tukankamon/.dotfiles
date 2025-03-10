{ config, pkgs, lib, ... }:

{
imports = [ ./gnome.nix ];

gnome.enable = true;
}

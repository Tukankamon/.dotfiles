{ config, pkgs, lib, ... }:   #Need to make it str not bool
{
imports = [ ./gnome.nix ./hypr.nix ];

options ={
  placeholder.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "idk";
  };
};

config = lib.mkIf config.placeholder.enable {
  gnome.enable = true;

};

}

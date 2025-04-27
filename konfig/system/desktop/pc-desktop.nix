{ inputs, pkgs, ... }:	#There is also a home manager for this to manage them

{
imports = [ ./../../../pc/hardware-configuration.nix ];

programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

xdg.portal = {			#This and nix settings is for hyprland
	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
};

environment.sessionVariables.NIXOS_OZONE_WL = "1";
#Forces wayland


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

}
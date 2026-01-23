{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    niri = lib.mkEnableOption {
      type = lib.types.bool;
      default = false;
      description = "Enable de niri scrolling WM";
    };
  };

  config = lib.mkIf config.niri {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.niri.enable = true;

    #For noctalia shell you need it in a flake
    environment.systemPackages = with pkgs; [
      waybar
      #alacritty
      fuzzel
      swaybg
      swaylock
      mako #notification daemon
      xwayland-satellite # Support for Xwayland (doesnt quite work)
      wlogout # Logout menu, not update in over a year so be careful
      udiskie # Auto mount (GUI), if not usb needs to be mounted manually
      foot #Terminal on wayland, supposed to bet faster

      # Gnome stuff
      nautilus # File manager
      gnome-disk-utility # Very nice gui for disks
    ];

    services = {
      udisks2.enable = true; # Semi automounting usbs, use udiske (home-manager) for GUI and notis
      gvfs.enable = true; # This aswell, polkit needs to be enabled aswell
    };
  };
}

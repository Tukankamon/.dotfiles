{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
# INputs bc stylix will break even when not using it
{
  options = {
    gnome = lib.mkEnableOption {
      type = lib.types.bool;
      default = false;
      description = "Aux option to enable gnome, use the desktop option to actually set it";
    };
  };

  config = lib.mkIf config.gnome {
    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      gnome-software # Gui install flatkpak
      gnome-tour
      epiphany
      geary
      yelp
      totem
    ];

    environment.systemPackages = with pkgs; [
      dconf-editor
      gnome-tweaks

      # Extensions are customized in the home settings
      gnomeExtensions.blur-my-shell # doesnt work rn
      gnomeExtensions.gsconnect
      gnomeExtensions.appindicator
    ];

    stylix = {
      # This is just half, the other is in the home module
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml"; #Could change this
      image = ./../../../other/images/roadwp.jpg;
      autoEnable = false;
      targets = {
        chromium.enable = true;
      };
    };
  };
}

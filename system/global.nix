{
  inputs,
  pkgs,
  config,
  lib,
  #configuration,
  ...
}:
{
  imports = [
    ./../development/programming.nix
    ./modules/autofirma.nix
    ./modules/desktop.nix
    ./modules/boot.nix
    ./sysPackages.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"]; # Forgot what this does

  programs.command-not-found.enable = true;
  programs.nix-index = {
    #doesnt work
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  networking.firewall = {
    # for gsconnect
    enable = true;
    allowedTCPPorts = [1716];
    allowedUDPPorts = [1716];
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-software # Gui install flatkpak
    gnome-tour
    epiphany
    geary
    yelp
    totem
  ];

  virtualisation.virtualbox.host.enable = true;

  # Set your time zone.
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Madrid";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.wacom.enable = true; # Dont think this is necessary (works iffy without it)

  environment.variables = {
    EDITOR = "gnome-text-editor"; # Gnome text editor
    TERM = "xterm-256color"; # to be able to clear in ssh
  };

  programs.obs-studio.enableVirtualCamera = true;

  environment.sessionVariables = {
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = 0; # for fullscreen videogames
  };

  /*
  From stylix
  Default background: base00
  Alternate background: base01
  Selection background: base02
  Default text: base05
  Alternate text: base04
  Warning: base0A
  Urgent: base09
  Error: base08
  */
}

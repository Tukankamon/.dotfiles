{ inputs, pkgs, configuration, ... }:

{
  imports = [

  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

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

  environment.systemPackages = with pkgs; [
   home-manager
   fastfetch
   pipes
   cbonsai
   neo-cowsay
   vim
   lf
   git
   kitty
   fzf
   neovim
   asciiquarium-transparent
   parted                       #scan partitions
   testdisk
   ffmpeg
   qbittorrent
   tor-browser
   spotify
   brave
   vscodium		#Vscodium
   vscode
   librewolf
   protonmail-desktop
   protonmail-bridge
   protonvpn-gui
   dconf-editor
   signal-desktop
   mullvad-browser
];

  environment.gnome.excludePackages = with pkgs; [
	gnome-tour
  epiphany

  ];
}

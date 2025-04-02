{
  inputs,
  pkgs,
  #configuration,
  ...
}:

{
  imports = [

  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

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
    parted # scan partitions
    testdisk
    ffmpeg
    qbittorrent
    tor-browser
    spotify
    brave
    vscodium # Vscodium
    vscode
    #protonmail-desktop
    #protonmail-bridge
    protonvpn-gui
    dconf-editor
    signal-desktop
    mullvad-browser # (recommended pretty much only if you have the vpn)
    #alejandra  #Nix formatter
    nixfmt-rfc-style # Nix formatter (official)
    nixd # Nix language server (highlighting and stuff) (Ctrl, shift I in vscode to apply to file)
    gimp
    tokei # Count lines of code per language
    nvd #Check the pkg difference between generations
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    geary

  ];
}

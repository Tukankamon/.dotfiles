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

  services.xserver.wacom.enable = true; #Dont think this is necessary (works iffy without it)

  #environment.variables.EDITOR = "gnome-text-editor"; #Gnome text editor

  environment.systemPackages = with pkgs; [

    /* Terminal and config */
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
    ack   #Finds words in codebases
    #alejandra  #Nix formatter
    nixfmt-rfc-style # Nix formatter (official)
    nixd # Nix language server (highlighting and stuff) (Ctrl, shift I in vscode to apply to file)
    libinput #Idk if necessary for wacom tablet
    libwacom #Wacom specifically

    /*  GUIS */
    qbittorrent
    tor-browser
    spotify
    brave
    vscodium
    vscode
    #protonmail-desktop
    #protonmail-bridge
    protonvpn-gui
    signal-desktop
    mullvad-browser # (recommended pretty much only if you have the vpn)
    gimp
    tokei # Count lines of code per language
    nvd #Check the pkg difference between generations
    anki
    obsidian  #Notes and "mini essays" (Odysseas on YT)
    #logseq #Similar to obisidian, keep an eye on it
    #zettlr #Another FOSS markdown editor to keep an eye on
    rnote #To use with the wacom
    #wacomtablet #self explanatory, from KDE (doesnt work) (Could also try pkgs.libwacom)

  ];

}

{
  inputs,
  pkgs,
  config,
  #configuration,
  ...
}: {
  imports = [
    ./../development/programming.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    kernelModules = [ "snd-seq" "snd-rawmidi" ];
  };
  security.polkit.enable = true;  # I think this is also needed


  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"]; #Forgot what this does

  programs.command-not-found.enable = true;
  programs.nix-index = { #doesnt work
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration= false;
  };

  networking.firewall = {  # for gsconnect
    enable = true;
    allowedTCPPorts = [ 1716 ];
    allowedUDPPorts = [ 1716 ];
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-software #Gui install flatkpak
    gnome-tour
    epiphany
    geary
    yelp
  ];

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    /*
    Terminal and config
    */
    home-manager
    fastfetch
    pipes
    cbonsai
    neo-cowsay
    lf
    yazi # Better lf, keeping the old bc it is much more comortable to type
    git
    kitty
    fzf  #fuzzy file search, needed for zoxide
    neovim
    asciiquarium-transparent
    parted # scan partitions
    testdisk
    ffmpeg
    ripgrep #better grep
    #libinput #Idk if necessary for wacom tablet
    libwacom #Wacom specifically
    toybox #CLI utilities
    hyperfine #command benchmark
    #helix  #nvim with better defaults
    universal-android-debloater
    zoxide  # better cd
    dysk
    exiftool   #Metadata image scanner
    tokei # Count lines of code per language
    nvd #Check the pkg difference between generations
    caligula #Burning flash drives
    #ventoy #Marked as insecure by NIX
    efibootmgr

    /*
    GUIS
    */
    bottles
    virtualbox
    qbittorrent
    tor-browser
    spotify
    brave
    librewolf
    vscodium
    vscode
    #protonmail-desktop
    #protonmail-bridge
    protonvpn-gui
    #signal-desktop  # Build error
    mullvad-browser # (recommended pretty much only if you have the vpn)
    gimp3
    anki
    obsidian #Notes and "mini essays" (Odysseas on YT)
    #logseq #Similar to obisidian, keep an eye on it
    #zettlr #Another FOSS markdown editor to keep an eye on
    rnote #To use with the wacom
    #wacomtablet #self explanatory, from KDE (doesnt work) (Could also try pkgs.libwacom)
    kiwix
    gnome-network-displays #For sharing to a tv
    inputs.zen-browser.packages."x86_64-linux".default #https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file
    obs-studio
    arduino-ide
    lact
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

  services.xserver.wacom.enable = true; #Dont think this is necessary (works iffy without it)

  environment.variables = {
    EDITOR = "gnome-text-editor"; #Gnome text editor
    TERM = "xterm-256color"; #to be able to clear in ssh
    };

  programs.obs-studio.enableVirtualCamera = true;

  environment.sessionVariables = {
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = 0;  #for fullscreen videogames
  };
}

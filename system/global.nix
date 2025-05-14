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

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];    #Forgot what this does

    environment.gnome.excludePackages = with pkgs; [
    gnome-software    #Gui install flatkpak
    gnome-tour
    epiphany
    geary
    yelp

  ];


  environment.systemPackages = with pkgs; [

    /* Terminal and config */
    home-manager
    fastfetch
    pipes
    cbonsai
    neo-cowsay
    vim-full
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
    toybox  #CLI utilities

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
    gimp3
    tokei # Count lines of code per language
    nvd #Check the pkg difference between generations
    anki
    obsidian  #Notes and "mini essays" (Odysseas on YT)
    #logseq #Similar to obisidian, keep an eye on it
    #zettlr #Another FOSS markdown editor to keep an eye on
    rnote #To use with the wacom
    #wacomtablet #self explanatory, from KDE (doesnt work) (Could also try pkgs.libwacom)
    kiwix
    caligula  #Burning flash drives
    #ventoy #Marked as insecure by NIX
    gnome-network-displays #For sharing to a tv
    inputs.zen-browser.packages."x86_64-linux".default   #https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file

    /* CPP */
    clang-tools
    cmake
    codespell
    conan
    cppcheck
    doxygen
    gtest
    lcov
    vcpkg
    vcpkg-tool
    libgcc # Compiler
    gcc
    gdb

  ];

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

  environment.variables.EDITOR = "gnome-text-editor"; #Gnome text editor

  /*
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
    */

}

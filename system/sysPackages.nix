{
  pkgs,
  stablePkgs,
  lib,
  ...
}: let
  stable = with stablePkgs; [
    kicad # Very often will try to build from source on unstable
    librewolf # Same as kicad
  ];

  unstable = with pkgs; [
    #Unfree
    obsidian
    #spotify

    # Terminal and config
    home-manager
    tree
    fastfetch
    pipes
    cbonsai
    neo-cowsay
    lf
    yazi # Better lf, keeping the old bc it is much more comortable to type
    bat # Better cat
    git
    kitty
    fzf # fuzzy file search, needed for zoxide
    kew #music player
    neovim
    asciiquarium-transparent
    parted # scan partitions
    #gparted # Gui version of parted # BROKEN permission error
    #testdisk # Only really usable with live boots
    #efibootmgr # Same as above
    ffmpeg
    gnuplot_qt #2d and 3d plotting software
    ripgrep # better grep
    #libinput #Idk if necessary for wacom tablet
    #libwacom # Wacom specifically
    #hyperfine # command benchmark
    btop # Task manager for the terminal
    universal-android-debloater
    zoxide # better cd
    dysk # See disk usage
    exiftool # Metadata image scanner
    tokei # Count lines of code per language
    nvd # Check the pkg difference between generations
    caligula # Burning flash drives
    #ventoy #Marked as insecure by NIX
    bluetui #Bluetooth TUI
    #typst # Turing complete latex alternative (easier)
    #stress-ng # Stress test CPU

    # --- GUIS --- 
    kooha # Gif recorder but also ss and normal recordings
    vlc
    bottles
    audacity
    qbittorrent
    tor-browser
    brave
    #libreoffice
    pavucontrol #Audio control
    zathura #PDF with vim binds
    vscodium
    #protonvpn-gui
    signal-desktop
    #mullvad-browser # (recommended pretty much only if you have the vpn)
    gimp3
    pdftricks
    #anki   #Build error
    #kiwix  #Uses Qt5 which is unmaintained and unsafe, will reinstall when maintained
    #gnome-network-displays # For sharing to a tv
    obs-studio
    #arduino-ide
    lact
    #gcolor3 # Screen color picker
    qdirstat # See how much storage space each folder uses, GUI
  ];
in {
  imports = [./packages];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      #Doesnt install, just allows
      "obsidian"
      #"spotify"
      "steam"
      "steam-unwrapped"
      "discord"
    ];

  environment.systemPackages = stable ++ unstable;
}

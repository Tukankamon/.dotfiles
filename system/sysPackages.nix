{
  pkgs,
  stablePkgs,
  lib,
  ...
}: let
  stable = with stablePkgs; [
    #kicad # Very often will try to build from source on unstable
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
    tealdeer # Less extensive man pages for quicker understanding (tldr)
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
    fd # Better find
    #libinput #Idk if necessary for wacom tablet
    #libwacom # Wacom specifically
    hyperfine # command benchmark
    btop # Task manager for the terminal
    universal-android-debloater
    zoxide # better cd
    eza # ls improved
    dysk # See disk usage
    exiftool # Metadata image scanner
    tokei # Count lines of code per language
    nvd # Check the pkg difference between generations
    caligula # Burning flash drives
    bluetui #Bluetooth TUI
    dotter # Dotfiles manager in combination with home manager, better than stow
    tree-sitter # Needed for some neovim plugins
    tmux

    # --- GUIS ---
    kooha # Gif recorder but also ss and normal recordings
    vlc
    #bottles
    audacity
    qbittorrent
    tor-browser
    brave
    librewolf
    #libreoffice
    pavucontrol #Audio control
    vscodium
    #protonvpn-gui
    signal-desktop
    #mullvad-browser # (recommended pretty much only if you have the vpn)
    gimp3
    pdftricks
    localsend #airdrop alternative
    #anki   #Build error
    #kiwix  #Uses Qt5 which is unmaintained and unsafe, will reinstall when maintained
    #gnome-network-displays # For sharing to a tv
    obs-studio
    lact
    #gcolor3 # Screen color picker
    qdirstat # See how much storage space each folder uses, GUI
    #thunderbird # Email
    #rpi-imager
    nicotine-plus # P2P music sharing, different from torrents
    strawberry # FOOBAR2000-like music player
  ];
in {
  imports = [./packages];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      #Doesnt install, just allows
      "obsidian"
      "spotify"
      "steam-unwrapped"
      "steam"
    ];

  environment.systemPackages = stable ++ unstable;
}

{
    pkgs,
    stablePkgs,
    lib,
    config,
    inputs,
    ...
}: let
    stable = with stablePkgs; [];

    unstable = with pkgs; [
        #Unfree
        obsidian
        spotify

        # Terminal and config
        home-manager
        tree
        fastfetch
        pipes
        cbonsai
        neo-cowsay
        lf
        yazi # Better lf, keeping the old bc it is much more comortable to type
        git
        kitty
        fzf # fuzzy file search, needed for zoxide
        kew #music player
        neovim
        asciiquarium-transparent
        parted # scan partitions
        gparted # Gui version of parted
        testdisk
        ffmpeg
        gnuplot_qt #2d and 3d plotting software
        ripgrep # better grep
        #libinput #Idk if necessary for wacom tablet
        #libwacom # Wacom specifically
        #toybox # CLI utilities
        hyperfine # command benchmark
        htop # Task manager for the terminal
        #helix  #nvim with better defaults
        universal-android-debloater
        zoxide # better cd
        dysk
        exiftool # Metadata image scanner
        tokei # Count lines of code per language
        nvd # Check the pkg difference between generations
        caligula # Burning flash drives
        #ventoy #Marked as insecure by NIX
        efibootmgr
        bluetui #Bluetooth TUI
        #typst # Turing complete latex alternative (easier)
        stress-ng

        # GUIS
        kooha # Gif recorder but also ss and normal recordings
        vlc
        bottles
        audacity
        qbittorrent
        tor-browser
        brave
        librewolf
        libreoffice
        pavucontrol #Audio control
        zathura #PDF with vim binds
        foot #Terminal on wayland, supposed to bet faster
        vscodium
        #zed-editor # IDE
        #protonmail-desktop
        #protonmail-bridge
        #protonvpn-gui
        #signal-desktop  # Build error
        mullvad-browser # (recommended pretty much only if you have the vpn)
        gimp3
        pdftricks
        #anki   #Build error
        #logseq #Similar to obisidian, keep an eye on it
        #zettlr #Another FOSS markdown editor to keep an eye on
        #rnote # To use with the wacom
        #wacomtablet #self explanatory, from KDE (doesnt work) (Could also try pkgs.libwacom)
        #kiwix  #Uses Qt5 which is unmaintained and unsafe, will reinstall when maintained
        gnome-network-displays # For sharing to a tv
        obs-studio
        arduino-ide
        lact
        gcolor3
        kicad
        emacs
        fd # Alternative to find command, needed for emacs (doom atleast)
    ];
in {
    nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
            #Doesnt install, just allows
            "obsidian"
            "spotify"
            "steam"
            "steam-unwrapped"
            "discord"
        ];

    environment.systemPackages = stable ++ unstable;

    programs = {
        adb.enable = true;
    };
}

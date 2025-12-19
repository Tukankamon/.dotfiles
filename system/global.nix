{
    inputs,
    pkgs,
    config,
    lib,
    #configuration,
    ...
}: {
    imports = [
        ./../development/programming.nix
        ./modules/autofirma.nix
        ./modules/desktopBundle.nix
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
    # Enable the X11 windowing system.
    #services.xserver.videoDrivers = [ "amdgpu" ];
    services.xserver = {
        enable = true;

        # Configure keymap in X11
        # https://man.archlinux.org/man/xkeyboard-config-2.7.en
        xkb = {
            layout = "es";
            variant = "";
            options = "swapescap";
        };
        autoRepeatInterval = 50;
        autoRepeatDelay = 0;
    };
    # Configure console keymap
    console.keyMap = "es";


    environment.variables = {
        EDITOR = "vim"; # Gnome text editor
        TERM = "xterm-256color"; # to be able to clear in ssh
    };

    programs.obs-studio.enableVirtualCamera = true;

    environment.sessionVariables = {
        SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = 0; # for fullscreen videogames
    };
}

{pkgs, ...}: {
  imports = [
    ./sysPackages.nix

    ./modules/desktop
    ./modules/ollama
    ./modules/boot.nix
    ./modules/autofirma.nix
    ./modules/gaming.nix
    ./modules/amd.nix
    ./modules/music.nix
    ./modules/specialisation.nix
    ./modules/users.nix
    ./modules/gammastep.nix
    ./modules/zathura.nix
    ./modules/phonedrop.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  modules = {
    boot.enable = true;
    specialisation.enable = true;
    users.enable = true; # This has more options, check users.nix for more info
    gammastep.enable = true;
    zathura.enable = true;
    music.enable = true;
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  # SSH daemon is on for the system recieving files
  # So activating for both will give a two way connection
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false; # Only SSH connection, no passwd
      AllowUsers = ["aved"];
    };
  };

  networking.extraHosts = ''
    192.168.0.185 dwebble
    192.168.0.186 yamask
    192.168.1.65 ekko
  '';

  networking.networkmanager.enable = true;
  #networking.wireless.iwd.enable = true; # For impala tui, BROKEN

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = false;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
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

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      wacom.enable = true;
      # Configure keymap in X11
      # https://man.archlinux.org/man/xkeyboard-config-2.7.en
      xkb = {
        layout = "es";
        variant = "";
        options = "caps:escape";
      };
      autoRepeatInterval = 50;
      autoRepeatDelay = 0;
    };

    # Kills processes when RAM usage is too much so it doesn't hang
    # Useful if nix tries to build from source something like a browser (actually works)
    earlyoom = {
      enable = true;

      # WARNING: enabling this option (while convenient) should not be done
      # on a machine where you do not trust the other users as it allows
      # any other local user to DoS your session by spamming notifications.
      #enableNotifications = true; # BROKEN

      # Default is 3600s, seems to long to me
      #reportInterval = 3600;

      killHook = pkgs.writeShellScript "earlyoom-kill-hook" ''
        echo "========================="
        echo -e "Process $EARLYOOM_NAME was killed (owned by $EARLYOOM_UID)"
        echo "========================="
      '';

      # Kills browser before compilers so this doesnt really work
      extraArgs = [
        "--prefer"
        "'^(gcc|clang|clang\+\+|rustc)$'"
      ];
    };
  };

  # Configure console keymap
  console.keyMap = "es";

  environment.variables = {
    EDITOR = "nvim";
    TERM = "xterm-256color"; # to be able to clear in ssh
  };
  #environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf"; #Doesnt worK and sometimes messes if the main package is from stable

  programs.obs-studio.enableVirtualCamera = true;

  environment.sessionVariables = {
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = 0; # for fullscreen videogames
  };
}

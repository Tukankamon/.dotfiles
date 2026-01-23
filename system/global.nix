{
  inputs,
  pkgs,
  #ib,
  #configuration,
  ...
}: {
  imports = [
    ./sysPackages.nix

    ./modules/desktop
    ./modules/ollama
    ./modules/boot.nix
    ./modules/autofirma.nix
    ./modules/gaming.nix
    ./modules/amd.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"]; # Forgot what this does

  # SSH daemon is on for the system recieving files
  # So activating for both will give a two way connection
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false; # Only SSH connection, no passwd
      AllowUsers = [ "aved" ];
    };
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

  };

  # Configure console keymap
  console.keyMap = "es";

  environment.variables = {
    EDITOR = "vim";
    TERM = "xterm-256color"; # to be able to clear in ssh
  };
  #environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf"; #Doesnt worK and sometimes messes if the main package is from stable

  programs.obs-studio.enableVirtualCamera = true;

  environment.sessionVariables = {
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = 0; # for fullscreen videogames
  };
}

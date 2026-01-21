{
  inputs,
  pkgs,
  #pkgs-stable,
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./../system/global.nix
  ];

  specialisation = {
    gnome.configuration = {
      # Builds a second boot entry for gnome
      desktop = "gnome";
    };
  };

  # ONly applies to the default system
  desktop = lib.mkIf (config.specialisation != {}) "niri";

  modules = {
    ollama.enable = true;
    boot.enable = true;
    autofirma.enable = false;
  };

  home-manager = {
    # Not necesary but now hm also rebuilds with nixos-rebuild
    extraSpecialArgs = {inherit inputs;};
    users.aved = import ./home.nix;
  };

  networking.hostName = "yamask"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = false;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aved = {
    isNormalUser = true;
    description = "aved";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "dialout" # For arduino and stuff
    ];

    # Set the password using the passwd command. That way it is not stored inside of the config file
    # If you still want it to be declarative, has it with mkpasswd and set it below
    #hashedPassword = "";

    packages = with pkgs; [
      # Zen browser add like 400 package dependencies and my OCD doesnt like that
      # https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file
      inputs.zen-browser.packages."x86_64-linux".default

      xonotic # FOSS quake-like game
    ];
  };

  users.extraGroups.vboxusers.members = ["aved"];

  environment.shells = with pkgs; [fish]; # Following a video
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  programs.steam = {
    #Unfree
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          gamescope
        ];
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    #inputs.vible.packages.x86_64-linux.default
    mangohud # Fps overlay (add mangohud %command% to steam launch options in the game)

    discord #Unfree
    #darktable  # Breaks in unstable
    #davinci-resolve
    deadnix #Scan for unused nix code   (https://github.com/astro/deadnix)
    #jetbrains.idea-community   #for developing in kotlin
    kdePackages.kdenlive
    #rpi-imager #Broken
    prismlauncher
    #heroic
    audacity
  ];

  fonts.packages = with pkgs; [
    # I dont remember why I have so many
    #font-awesome
    #font-awesome_5
    #font-awesome_6

    #nerd-fonts.code-new-roman
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
  ];

  #systemd.packages = with pkgs; [ lact ];
  #systemd.services.lactd.wantedBy = ["multi-user.target"];
  hardware = {
    #For davinci resolve
    enableRedistributableFirmware = true; # ChatGPT recommendation
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
      ];
    };
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

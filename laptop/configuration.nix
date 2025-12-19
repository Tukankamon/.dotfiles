{
    inputs,
    pkgs,
    # configuration,
    ...
}:
# add inputs
{
    imports = [
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager
        ./../system/global.nix
        ./../development/script.nix
    ];

    grub-boot.enable = true;
    desktop = "niri";

    home-manager = {
        extraSpecialArgs = {inherit inputs;};
        users.aved = import ./home.nix;
    };

    networking.hostName = "dwebble"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    #hardware.pulseaudio.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        #jack.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.aved = {
        isNormalUser = true;
        description = "aved";
        extraGroups = [
            "networkmanager"
            "wheel"
            #"input"
        ];
        password = "aved";

        packages = with pkgs; [
            #  thunderbird
            inputs.zen-browser.packages."x86_64-linux".default # https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file
        ];
    };

    environment.shells = with pkgs; [fish]; # Following a video
    users.defaultUserShell = pkgs.fish;
    programs.fish.enable = true;

    environment.systemPackages =
        # with pkgs;
        [
            #gnomeExtensions.search-light
            #sops
            #  wget
        ];

    fonts.packages = with pkgs; [
        #font-awesome
        #font-awesome_5
        #font-awesome_6
        #nerd-fonts.code-new-roman
        nerd-fonts.jetbrains-mono
        #pkgs.nerd-fonts.fira-code
        #pkgs.nerd-fonts.droid-sans-mono
        #pkgs.nerd-fonts.hack
    ];
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?

    #TODO setting this to false will break noctalia shell daemon
    services.power-profiles-daemon.enable = false;
    #services.upower.enable = true; #Same thing as above

    powerManagement.enable = true; # laptop battery
    services.thermald.enable = true;

    services.tlp = {
        enable = true;
        settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 20;
        };
    };

    /*
  services.libinput = {
  enable = true;
  # disabling mouse acceleration
  mouse = {
    accelProfile = "flat";
  };

  # disabling touchpad acceleration
  touchpad = {
    accelProfile = "flat";
  };
  };
  */
}

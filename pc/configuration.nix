{
    inputs,
    pkgs,
    pkgs-stable,
    config,
    lib,
    ...
}: {
    imports = [
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager
        ./../system/global.nix
        ./../development/script.nix
    ];

    /*
  specialisation.gnome.configuration = { # Builds a second boot entry for gnome
      desktop = "gnome";
  };
  */

    # To avoid getting niri conf in gnome
    desktop = lib.mkIf (config.specialisation == {}) "niri";

    grub-boot.enable = true;

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

       hashedPassword = "$y$j9T$V8fcqlSY6CKWRjX6fsffR.$Im1Sttp46CQIw9J/ZIf5x6LdaUziJxxLf5hyub8gIv1";

        packages = with pkgs; [
            inputs.zen-browser.packages."x86_64-linux".default # https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file
        ];
    };

    users.extraGroups.vboxusers.members = ["aved"];

    environment.variables = {
        #For amd stuff
        #ROC_ENABLE_PRE_VEGA = "1";
        /*
      RUSTICL_ENABLE="amdgpu";
    DRI_PRIME= "1";
    QT_QPA_PLATFORM = "xcb davinci-resolve";
    */
    };

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
        sops
        #darktable  # Breaks in unstable
        #davinci-resolve
        #deadnix  #Scan for unused nix code   (https://github.com/astro/deadnix)
        nix-output-monitor # eye candy for nix develop and shell
        #jetbrains.idea-community   #for developing in kotlin
        kdePackages.kdenlive
        #android-studio #Unfree
        #distrobox #Distro containers
        #revolt-desktop discord alternative
        nurl # Fetching urls
        rpi-imager #broken
        prismlauncher
        heroic
        macchanger
        audacity
        inkscape
    ];

    fonts.packages = with pkgs; [
        font-awesome
        font-awesome_5
        font-awesome_6

        nerd-fonts.code-new-roman
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.nerd-fonts.fira-code
        pkgs.nerd-fonts.droid-sans-mono
        pkgs.nerd-fonts.hack
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

    services.power-profiles-daemon.enable = false;

    services.thermald.enable = true;
}

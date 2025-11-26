{
    inputs,
    pkgs,
    pkgs-stable,
    config,
    lib,
    ...
}:
{
    imports = [
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager
        ./../system/global.nix
        ./../development/script.nix
    ];

    grub-boot.enable = true;
    desktop = "gnome"; #default   #Remember to also enable in home manager or you will  get stuck

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

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    #services.xserver.videoDrivers = [ "amdgpu" ];

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "es";
        variant = "";
    };

    services.xserver.autoRepeatDelay = 0;
    services.xserver.autoRepeatInterval = 50;

    # Configure console keymap
    console.keyMap = "es";

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

        password = "aved";

        /*
    packages = with pkgs; [
      #  thunderbird
    ];
    */
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
        enable = true;
        gamescopeSession.enable = true;
    };

    programs.gamescope = {
        enable = true;
        capSysNice = true;
    };

    programs.gamemode.enable = true;

    nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
            "steam"
        ];


    environment.systemPackages =
    (with pkgs; [
        #inputs.vible.packages.x86_64-linux.default
        mangohud # Fps overlay (add mangohud %command% to steam launch options in the game)
        discord
        sops
        #darktable  # Breaks in unstable
        #davinci-resolve
        #deadnix  #Scan for unused nix code   (https://github.com/astro/deadnix)
        nix-output-monitor # eye candy for nix develop and shell
        libreoffice
        #jetbrains.idea-community   #for developing in kotlin
        kdePackages.kdenlive
        android-studio
        #distrobox #Distro containers
        pavucontrol # better audio control
        #revolt-desktop discord alternative
        nurl # Fetching urls
        #rpi-imager #broken
        prismlauncher
        heroic
        macchanger
    ])

    ++

    (with pkgs-stable; [
        audacity
    ]);

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

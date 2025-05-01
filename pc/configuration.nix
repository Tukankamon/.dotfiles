{
  inputs,
  pkgs,
  # configuration,
  ...
}: # add inputs

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./../konfig/system/pc.nix
    ./../konfig/system/global.nix
    ./../development/script.nix
  ];

  pc-boot.enable = true;

  home-manager = {
    # Not necesary but now hm also rebuilds with nixos-rebuild
    extraSpecialArgs = { inherit inputs; };
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
  services.xserver.enable = false;
  #services.xserver.videoDrivers = [ "amdgpu-pro" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

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
    ];
    password = "aved";
    /*
      packages = with pkgs; [
        #  thunderbird
      ];
    */
  };

  programs.firefox.enable = false;

  /*environment.variables = {   #For amd stuff
    ROC_ENABLE_PRE_VEGA = "1";
};*/

  environment.shells = with pkgs; [ fish ]; # Following a video
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud # Fps overlay (add mangohud %command% to steam launch options in the game)
    discord
    signal-desktop
    sops
    darktable
    davinci-resolve
    obs-studio
    librewolf
    #deadnix  #Scan for unused nix code   (https://github.com/astro/deadnix)
    nix-output-monitor  #eye candy for nix develop and shell
    (writeShellScriptBin "deploy" ''
      nohup brave &
      nohup codium &
      nohup discord &
    '') # Custom bash script to open programs
    libreoffice
    audacity
    #jetbrains.idea-community   #for developing in kotlin
    #kdePackages.kdenlive
    android-studio
    #distrobox #Distro containers
    pavucontrol #better audio control
    #revolt-desktop discord alternative
    nurl #Fetching urls
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

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  nixpkgs.config.allowUnfree = true;
}

/*
  stylix.base16Scheme = {
   base00 = "1f262d";  #terminal bg (defualt is #485867) (brush trees dark)
   base01 = "5A6D7A";
   base02 = "6D828E";
   base03 = "8299A1";
   base04 = "98AFB5";
   base05 = "B0C5C8";
   base06 = "C9DBDC";
   base07 = "E3EFEF";
   base08 = "b38686";
   base09 = "d8bba2";
   base0A = "aab386";
   base0B = "87b386";
   base0C = "86b3b3";
   base0D = "868cb3";
   base0E = "b386b2";
   base0F = "b39f9f";

  };
*/

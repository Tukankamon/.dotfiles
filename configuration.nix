{ inputs, pkgs, configuration, ... }:	#add inputs

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./konfig/nvf.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {        #Not necesary but now hm also rebuilds with nixos-rebuild
    extraSpecialArgs = { inherit inputs; };
    users.aved = import ./home.nix;

  };   

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "spinfinity";
  };
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


 nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };  

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

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
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
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
    extraGroups = [ "networkmanager" "wheel" ];
    password = "aved";
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  programs.firefox.enable = false;
  
  environment.shells = with pkgs; [ fish];	#Following a video
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
   vim
   home-manager
   fastfetch
   pipes
   cbonsai
   neo-cowsay
   lf
   git
   kitty
   fzf
   neovim
   gnomeExtensions.blur-my-shell
   gnomeExtensions.tiling-shell
   gnomeExtensions.search-light
   vscodium		#Vscodium
   vscode 
   brave
   asciiquarium-transparent
   parted                       #scan partitions
   testdisk
  #  wget
  ];

  environment.gnome.excludePackages = with pkgs; [
	gnome-tour

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
  
  powerManagement.enable = true;      #laptop battery
  services.thermald.enable = true;

 services.tlp = {
  enable = true;
  settings= {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_BAT= "power";
    CPU_ENERGY_PERF_POLICY_ON_AC= "performance";

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
 nix.settings.experimental-features = ["nix-command" "flakes"];

}
 
 /*stylix.base16Scheme = {
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

 };*/

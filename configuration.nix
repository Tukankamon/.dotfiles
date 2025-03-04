# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).			

{ pkgs, configuration, ... }:	#add inputs

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #inputs.home-manager.nixos-Modules.home-manager
    ];

  /*home-manager = {
    #extraSpecialArgs = {inherit inputs;};
    users = {
      aved = import ./home.nix;
    };
    
  };*/


  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

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
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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

  # Install firefox.
  programs.firefox.enable = true;
  
  environment.shells = with pkgs; [ fish];	#Following a video
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   pkgs.home-manager
   pkgs.fastfetch
   pkgs.pipes
   pkgs.cbonsai
   pkgs.neo-cowsay
   pkgs.lf
   git
   kitty
   fzf
   neovim
   gnomeExtensions.blur-my-shell
   vscodium		#Vscodium
  #  wget
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
 

 stylix.enable = true;
 stylix.autoEnable = true;

 #stylix.targets.nvim.enable = true;
 #stylix.targest.nixvim.enable = false;     to disable specific targets

 #stylix.image = "home/aved/Desktop/astronaut.jpg"; 

 stylix.base16Scheme = {
  base00 = "000000";    #485867
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
 #stylix.cursor.package = pkgs.bibata-cursors;
 #stylix.cursor.name = "Bibata-Modern-Ice";

 nixpkgs.config.allowUnfree = true;
 nix.settings.experimental-features = ["nix-command" "flakes"];

}
 
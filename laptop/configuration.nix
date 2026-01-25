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
  ];

  desktop = "niri";

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.aved = import ./home.nix;
  };

  modules = {
    boot.enable = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."x86_64-linux".default # https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file
  ];

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

  # Set the password using the passwd command. That way it is not stored inside of the config file
  # If you still want it to be declarative, has it with mkpasswd and set it below
  #hashedPassword = "";
  users.users.aved = {
    isNormalUser = true;
    description = "aved";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  environment.shells = with pkgs; [fish]; # Following a video
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # setting this to false will break noctalia shell daemon
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
}

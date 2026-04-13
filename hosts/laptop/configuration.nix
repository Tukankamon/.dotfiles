{
  inputs,
  pkgs,
  config,
  ...
}:
# add inputs
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../system
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      hostname = config.networking.hostName;
    };
    users.aved = import ./home.nix;
  };

  environment.systemPackages = with pkgs; [
    # https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file
    #inputs.zen-browser.packages."x86_64-linux".default
  ];

  networking.hostName = "dwebble"; # Define your hostname.
  security.pki.certificates = [
    #(builtins.readFile ../other/ca.pem)
  ];

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

      # Should fix eduroam issues
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";
    };
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

{
  inputs,
  pkgs,
  stablePkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../system
  ];

  modules = {
    ollama.enable = false;
    autofirma.enable = false;
    gaming.enable = true;
    amd.enable = true;
    music.ardour.enable = true;
  };

  environment.systemPackages = with pkgs; [
    #inputs.vible.packages.x86_64-linux.default
    stablePkgs.vesktop # FOSS discord client
    #pkgs.godot
    #pkgs.blender
    #darktable  # Breaks in unstable
    #davinci-resolve
    deadnix #Scan for unused nix code   (https://github.com/astro/deadnix)
    #stablePkgs.kdePackages.kdenlive
    audacity
    #inputs.zen-browser.packages."x86_64-linux".default
  ];

  # Todo, either add this to the boot module or create a double boot one
  boot = {
    # From https://nix-community.github.io/lanzaboote/getting-started/prepare-your-system.html:
    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    loader.grub.enable = lib.mkForce false; # Claude recommendation
    loader.systemd-boot.enable = lib.mkForce false;
    loader.efi.canTouchEfiVariables = lib.mkForce true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      hostname = config.networking.hostName;
    };
    users.aved = import ./home.nix;
  };

  networking.hostName = "yamask"; # Define your hostname.

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

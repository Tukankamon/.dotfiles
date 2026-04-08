{
  inputs,
  pkgs,
  stablePkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./../system/global.nix
  ];

  modules = {
    ollama.enable = true;
    autofirma.enable = false;
    gaming.enable = true;
    amd.enable = true;
    ardour.enable = true;
  };

  environment.systemPackages = with pkgs; [
    #inputs.vible.packages.x86_64-linux.default
    discord #Unfree
    #pkgs.godot
    #pkgs.blender
    #darktable  # Breaks in unstable
    #davinci-resolve
    deadnix #Scan for unused nix code   (https://github.com/astro/deadnix)
    #stablePkgs.kdePackages.kdenlive
    audacity
    # https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file
    #inputs.zen-browser.packages."x86_64-linux".default
  ];

  home-manager = {
    # Not necesary but now hm also rebuilds with nixos-rebuild
    extraSpecialArgs = {inherit inputs;};
    users.aved = import ./home.nix;
  };

  networking.hostName = "yamask"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

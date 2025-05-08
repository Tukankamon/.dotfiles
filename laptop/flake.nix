{
  description = "Flake for Home-manager and shi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master"; # release-24.11 (syntax for stable branch)
      inputs.nixpkgs.follows = "nixpkgs"; # Check if the versions are the same
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input  
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*
      nvf = {
        url = "github:notashelf/nvf";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    */

    /*
      hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    */

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager, # hyprland,
      ...
    }@inputs: # If not inside the curly brackets you need to put inputs. e.g: inputs.nixpkgs...
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in
    {

      nixosConfigurations = {
        dwebble = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./configuration.nix
            # nvf.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        dwebble = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            /*
              {
              wayland.windowManager.hyprland = {
                enable = true;
                # set the flake package
                package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
                portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
              };
              }
            */

          ];
        };
      };

    };
}

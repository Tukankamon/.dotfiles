{
  description = "Flake for Home-manager and shi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05"; 
      inputs.nixpkgs.follows = "nixpkgs"; # Check if the versions are the same
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input  
      inputs.nixpkgs.follows = "nixpkgs";
    };

      nvf = {
        url = "github:notashelf/nvf";
        inputs.nixpkgs.follows = "nixpkgs";
      };

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
      nvf,
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
          ];
        };
      };

      homeConfigurations = {
        dwebble = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
          ];

          extraSpecialArgs = {
            inputs = builtins.removeAttrs inputs [ "self" ];
           };
        };
      };

    };
}

{
  description = "Flake for Home-manager and shi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    # Find a way to add unstable aswell

    home-manager = {
      url = "github:nix-community/home-manager/master";
      #url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; #Check if the versions are the same
    };

    vible = {
      #My own app
      url = "github:Tukankamon/vible";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Just some Nvim config stuff
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    autofirma-nix = {
      url = "github:nix-community/autofirma-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*
      hyprland = {
      url = "github:hyprwm/Hyprland";
      #inputs.hyprland.follows =
    };
    */
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    vible,
    /*
    hyprland,
    */
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      yamask = lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          ./configuration.nix
          inputs.stylix.nixosModules.stylix
          inputs.autofirma-nix.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      yamask = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          inputs = builtins.removeAttrs inputs ["self"];
        };
      };
    };
  };
}

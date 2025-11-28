{
    description = "Flake for Home-manager and shi";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "nixpkgs/nixos-25.05";
        # Find a way to add unstable aswell

        home-manager = {
            url = "github:nix-community/home-manager/master";
            #url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs"; # Check if the versions are the same
        };

        vible = {
            #My own app
            url = "github:Tukankamon/vible";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
            # to have it up-to-date or simply don't specify the nixpkgs input
            inputs.nixpkgs.follows = "nixpkgs";
        };

        #Just some Nvim config stuff
        nvf = {
            url = "github:notashelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        autofirma-nix = {
            url = "github:nix-community/autofirma-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        nvf,
        vible,
        nixpks-stable,
        # hyprland,
        ...
    } @ inputs: let
        lib = nixpkgs.lib;
        system = "x86_64-linux"; # Add this to machines if needed to specify
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-stable = nixpkgs-stable.legacyPackages.${system};

        machines = {
            yamask = { #PC
                nixosConfig = ./pc/configuration.nix;
                homeConfig = ./pc/home.nix;
                extraNixosModules = [];
                extraHomeModules = [];
            };
            dwebble = { # Laptop
                nixosConfig = ./laptop/configuration.nix;
                homeConfig = ./laptop/home.nix;
                extraNixosModules = [];
                extraHomeModules = [];
            };
        };

    in {
        nixosConfigurations = {
            yamask = lib.nixosSystem { #PC
                specialArgs = {inherit inputs system;};
                modules = [
                    ./pc/configuration.nix
                    inputs.stylix.nixosModules.stylix
                    inputs.autofirma-nix.nixosModules.default
                ];
            };

            dwebble = lib.nixosSystem { # Laptop
                specialArgs = {inherit inputs system;};
                modules = [
                    ./laptop/configuration.nix
                    inputs.stylix.nixosModules.stylix
                    inputs.autofirma-nix.nixosModules.default
                ];
            };
        };

        homeConfigurations = {
            yamask = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./pc/home.nix
                    inputs.stylix.homeModules.stylix
                ];

                extraSpecialArgs = {
                    inputs = builtins.removeAttrs inputs ["self"];
                };
            };

            dwebble = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./laptop/home.nix
                    inputs.stylix.homeManagerModules.stylix #Some are not available in the nixos module
                ];

                extraSpecialArgs = {
                    inputs = builtins.removeAttrs inputs ["self"];
                };
            };
        };
    };
}

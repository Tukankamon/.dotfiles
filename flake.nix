{
    description = "Flake for Home-manager and shi";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";

        # Latest stable release of nixpkgs
        nixpkgs-stable.url = "nixpkgs/nixos-25.05";

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

        # Check to see if this is in nixpkgs
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
            # to have it up-to-date or simply don't specify the nixpkgs input
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Neovim configuration
        nvf = {
            url = "github:notashelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Sets colorschemes and other stuff for most programs easily
        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Government stuff
        autofirma-nix = {
            url = "github:nix-community/autofirma-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # The name you choose here doesnt have to have anything to do with pname
        futureCursors = {
            url = "github:Tukankamon/Future-cursors";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        nvf,
        vible,
        nixpkgs-stable,
        ...
    } @ inputs: let
        system = "x86_64-linux";
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${system};
        stablePkgs = nixpkgs-stable.legacyPackages.${system};

        # Map for my hosts, any specific modules from one or the other go in extraXModules
        machines = {
            yamask = {
                #PC
                nixosConfig = ./pc/configuration.nix;
                homeConfig = ./pc/home.nix;
                extraNixosModules = [];
                extraHomeModules = [];
            };
            dwebble = {
                # Laptop
                nixosConfig = ./laptop/configuration.nix;
                homeConfig = ./laptop/home.nix;
                extraNixosModules = [];
                extraHomeModules = [];
            };
        };
    in {
        # Applies the machines map from before as a general configuration
        nixosConfigurations = builtins.mapAttrs (
            _: machine:
                nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs system stablePkgs;};

                    modules =
                        [
                            machine.nixosConfig
                            inputs.stylix.nixosModules.stylix
                            inputs.autofirma-nix.nixosModules.default
                        ]
                        ++ machine.extraNixosModules;
                }
        )
        machines;

        # Same as nixosConfigurations but for home manager
        homeConfigurations = builtins.mapAttrs (
            _: machine:
                home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;

                    modules =
                        [
                            machine.homeConfig
                            inputs.stylix.homeManagerModules.stylix
                        ]
                        ++ machine.extraHomeModules;

                    # I honestly dont know what this is for
                    extraSpecialArgs = {
                        inputs = builtins.removeAttrs inputs ["self"];
                    };
                }
        )
        machines;
    };
}

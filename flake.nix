{
  description = "Flake for Home-manager and shi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Latest stable release of nixpkgs
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      #url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Check if the versions are the same
    };

    # Check to see if this is in nixpkgs
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Government stuff
    autofirma-nix = {
      url = "github:nix-community/autofirma-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-stable,
    lanzaboote,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    unstablePkgs = nixpkgs.legacyPackages.${system};
    stablePkgs = nixpkgs-stable.legacyPackages.${system};

    # Map for my hosts, any specific modules from one or the other go in extraXModules
    machines = {
      yamask = {
        #PC
        branch = "unstable";
        nixosConfig = ./hosts/pc/configuration.nix;
        homeConfig = ./hosts/pc/home.nix;
        extraNixosModules = [lanzaboote.nixosModules.lanzaboote];
        extraHomeModules = [];
      };
      dwebble = {
        # Laptop
        branch = "unstable";
        nixosConfig = ./hosts/laptop/configuration.nix;
        homeConfig = ./hosts/laptop/home.nix;
        extraNixosModules = [];
        extraHomeModules = [];
      };
      ekko = {
        branch = "stable";
        nixosConfig = ./hosts/server/configuration.nix;
        extraNixosModules = [];
      };
    };
    pkgsFor = machine:
      if machine.branch == "stable"
      then stablePkgs
      else unstablePkgs;

    nixpkgsFor = machine:
      if machine.branch == "stabke"
      then nixpkgs-stable
      else nixpkgs;
  in {
    packages.${system}.default =
      # Run with nix run path/or/link/to/flake
      unstablePkgs.writeShellScriptBin "setup" (builtins.readFile ./setup.sh);

    nixosConfigurations =
      builtins.mapAttrs (
        _: machine:
          (nixpkgsFor machine).lib.nixosSystem {
            # Special Args allows you to import inputs and system inside every module
            specialArgs = {
              inherit inputs system stablePkgs unstablePkgs;
            };
            modules = [machine.nixosConfig] ++ machine.extraNixosModules;
          }
      )
      machines;

    # Same as nixosConfigurations but for home manager
    homeConfigurations =
      builtins.mapAttrs (
        _: machine:
          home-manager.lib.homeManagerConfiguration {
            pkgs = pkgsFor machine;
            modules = [machine.homeConfig] ++ machine.extraHomeModules;

            # Same as specialArgs but for home manager
            extraSpecialArgs = {
              inherit inputs;
            };
          }
      )
      # Only those with a declared home config
      (builtins.filterAttrs (_: m: m ? homeConfig) machines);
  };
}

{
  description = "Flake for Home-manager and shi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-mannager = {
      url = "github:nix-community/home-manager/master";	#release-24.11 (syntax for stable branch)
      inputs.nixpkgs.follows = "nixpkgs";	#Check if the versions are the same
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      };*/
    
  };

  outputs = { self, nixpkgs, home-manager, nvf, /*hyprland,*/ ... }@inputs:   #If not inside the curly brackets you need to put inputs. e.g: inputs.nixpkgs...
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";      
      pkgs = nixpkgs.legacyPackages.${system};
      
    in {

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {inherit inputs system;};
    	  modules = [ ./configuration.nix
		      nvf.nixosModules.default
		      ];
      };
    };
    
    homeConfigurations = {
      aved = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
    	  modules = [ ./home.nix 
          /*{
          wayland.windowManager.hyprland = {
            enable = true;
            # set the flake package
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          };
          } */
        
        ];
      };
    };
	
  };
}

{
  description = "Flake for Home-manager and shi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    # Find a way to add unstable aswell
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";	#Check if the versions are the same
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input  
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vible = { #My own app
        url = "github:Tukankamon/vible";
        inputs.nixpkgs.follows = "nixpkgs";
        };

    #Just some Nvim config stuff
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*hyprland = {
      url = "github:hyprwm/Hyprland";
      #inputs.hyprland.follows = 
    };*/
    
  };

  outputs = { self, nixpkgs, home-manager, nvf, vible, /*hyprland,*/ ... }@inputs:

    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";      
      pkgs = nixpkgs.legacyPackages.${system};
      
    in {

    nixosConfigurations = {
      yamask = lib.nixosSystem {
        specialArgs = {inherit inputs system;};
    	  modules = [ ./configuration.nix
		      ];
      };
    };
    
    homeConfigurations = {
      yamask = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
    	modules = [ ./home.nix 
        ];

        extraSpecialArgs = { 
           inputs = builtins.removeAttrs inputs [ "self" ];
        };
      };
    };
	
  };
}

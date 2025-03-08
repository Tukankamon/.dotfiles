{
  description = "Flake for Home-manager and shi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";	#release-24.11
    home-manager.inputs.nixpkgs.follows = "nixpkgs";	#Check if the versions are the same

    
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";      
      pkgs = nixpkgs.legacyPackages.${system};
      
    in {

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        #specialArgs = { inherit system; };
    	modules = [ ./configuration.nix ];
      };
    };
    
    homeConfigurations = {
      aved = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
    	modules = [ ./home.nix ];
      };
    };
	
  };
}

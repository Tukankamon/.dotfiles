{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };

  outputs = { nixpkgs, ... } @ inputs:
  {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { 
                inherit inputs;
                pkgs = import nixpkgs { system = "x86_64-linux"; };
          };
          modules = [
                ./configuration.nix
          ];
        };
  };
}

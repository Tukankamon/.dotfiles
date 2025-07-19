{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };

  outputs = { nixpkgs, ... } @ inputs:
  {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          specailArgs = { inherit inputs; };
          modules = [
                ./configuration.nix
          ];
        };
  };
}

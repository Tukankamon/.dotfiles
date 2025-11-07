{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
    };

    outputs = {nixpkgs, ...} @ inputs: let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            specialArgs = {
                inherit inputs;
            };
            modules = [
                ./configuration.nix
            ];
        };
    };
}

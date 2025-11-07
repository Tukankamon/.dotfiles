{
    description = "Nix minimal iso with flakes, git and utils";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    };

    outputs = {nixpkgs, ...} @ inputs: {
        nixosConfigurations = {
            nixIso = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs;};
                modules = [./configuration.nix];
            };
        };
    };
}

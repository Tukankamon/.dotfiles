{...}: {
  imports = [
    ./scripts
    ./programming.nix
  ];

  # Add self-wrapped packages here
  nixpkgs.overlays = [
    (import ./alejandra)
  ];

  # Also add any derivations here
}

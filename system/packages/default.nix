{ pkgs, ...}: {
  imports = [
    ./scripts
    ./programming.nix
    ./fonts.nix
  ];

  # Add self-wrapped packages here
  nixpkgs.overlays = [
    (import ./alejandra)
  ];

  # Also add any derivations here
  environment.systemPackages = with pkgs; [
    #(callPackage ./gulag.nix { }) # BROKEN
    (callPackage ./gulag/rust-lib.nix { }) #Just the library
  ];
}

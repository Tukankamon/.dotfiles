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
    #(callPackage ./gulag/rust-lib.nix { }) #Just the library

    # Number basis calculation in terminal
    (pkgs.stdenv.mkDerivation (finalAttrs: {
      pname = "con";
      version = "0.0.1";
      src = pkgs.fetchFromGitHub {
        owner = "Tukankamon";
        repo = "con";
        rev = "a9309146589db3814e7f7b2787c84a80b7075bdd";
        #rev = "v.${finalAttrs.version}";
        hash = "sha256-JK3zCtqYpHdP2RYDkV3mvw5ehCiinqHSQWj646F9dGU=";
      };
      installPhase = ''
        mkdir -p $out/bin
        cp bin/con $out/bin/
      '';
    }))

    (pkgs.haskellPackages.callCabal2nix "snow" (pkgs.fetchFromGitea {
      domain = "codeberg.org";
      owner = "Tukankamon";
      repo = "snow";
      rev = "e51bf38462";
      sha256 = "sha256-AaCdOxLa7p9bAqCzL2lgM7afXNX7xYaBL2hVgYwP1I0=";
    }) {})
  ];
}

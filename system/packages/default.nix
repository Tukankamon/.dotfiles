{pkgs, ...}: {
  imports = [
    ./scripts
    ./programming.nix
    ./snow
    ./themes.nix
    ./zennotes.nix
    ./phonedrop.nix
  ];

  # Add self-wrapped packages here
  nixpkgs.overlays = [
    (import ./alejandra)
  ];

  # Also add any derivations here
  environment.systemPackages = [
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
  ];
}

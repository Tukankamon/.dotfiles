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
        rev = "main";
        #rev = "v.${finalAttrs.version}";
        hash = "sha256-zBg9qF43YLYK+KRC5ph3LOaCT//kl/PLV4ugr5AH5WE=";
      };
      installPhase = ''
        mkdir -p $out/bin
        cp bin/con $out/bin/
      '';
    }))
  ];
}

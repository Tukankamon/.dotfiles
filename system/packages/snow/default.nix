{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "snow";
      src = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "Tukankamon";
        repo = "snow";
        rev = "788470096c";
        sha256 = "sha256-wXsBepFjd1UYuFbhpHVPSd2XKbm8EqHQRKZBMShlhdM=";
      };
      buildInputs = [(pkgs.haskellPackages.ghcWithPackages (ps: []))];
      # Add this line to buildPhase to change config file
      #cp ${./Config.hs} app/Config.hs
      buildPhase = ''
        ghc --make app/Main -iapp -outputdir build/ -o snow
      '';
      installPhase = ''
        mkdir -p $out/bin
        cp snow $out/bin/
      '';
    })
  ];
}

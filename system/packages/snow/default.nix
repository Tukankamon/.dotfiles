{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "snow";
      src = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "Tukankamon";
        repo = "snow";
        rev = "79be57611c";
        sha256 = "sha256-lNZT9+w8aeq+hxNtGhmbKqm8wcwzRwlYcRBXBBe8z40=";
      };
      buildInputs = [(pkgs.haskellPackages.ghcWithPackages (hs: []))];
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

{ pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "snow";
      src = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "Tukankamon";
        repo = "snow";
        rev = "17daf06ecd";
        sha256 = "sha256-mC3/XLGkdW+iaclZ/N6IjtHmnHd/q9kdHO/JVmVJRrY=";
      };
      buildInputs = [ (pkgs.haskellPackages.ghcWithPackages (ps: [])) ];
      buildPhase = ''
        # Uncomment this line to change config file
        #cp ${./Config.hs} app/Config.hs
        ghc --make app/Main -iapp -outputdir build/ -o snow
      '';
      installPhase = ''
        mkdir -p $out/bin
        cp snow $out/bin/
      '';
    })
  ];
}

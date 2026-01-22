final: prev: let
  config = ./alejandra.toml;
in {
  alejandra-unwrapped = prev.alejandra;
  alejandra = prev.symlinkJoin {
    name = "alejandra";
    paths = [prev.alejandra];
    buildInputs = [prev.makeWrapper];

    postBuild = ''
      mkdir -p $out/etc/alejandra
      cp ${config} $out/etc/alejandra/alejandra.toml

      wrapProgram $out/bin/alejandra \
          --append-flags "--experimental-config $out/etc/alejandra/alejandra.toml"
    '';
  };
}

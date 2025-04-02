{
  description = "Scripts flake (attempt)";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in
    {
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.my-script;

      packages.x86_64-linux.my-script = pkgs.writeShellScriptBin "my-script" ''
        DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
        ${pkgs.cowsay}/bin/cowsay Hello, world! Today is $DATE.
      '';

    };
}

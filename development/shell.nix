#Need to look into doing this with flakes

{ pkgs ? import <nixpkgs> {} }: 

pkgs.mkShell {
  #General nix shell
  packages = [
    pkgs.texliveFull
    (pkgs.python3.withPackages(pypkgs: with pypkgs; [
      #All the python libraries
      numpy
      requests
      manim
    ]))
  ];

}

#Need to look into doing this with flakes

{ pkgs ? import <nixpkgs> {} }: 

pkgs.mkShell {
  #General nix shell
  packages = with pkgs; [
    #Cpp
    clang-tools
    cmake
    codespell
    conan
    cppcheck
    doxygen
    gtest
    lcov
    vcpkg
    vcpkg-tool
    libgcc    #Compiler
    gcc
    gdb

    #Python
    #texliveFull
    (pkgs.python3.withPackages(pypkgs: with pypkgs; [
      #All the python libraries
      numpy
      requests
      #manim
    ]))
  ];

}

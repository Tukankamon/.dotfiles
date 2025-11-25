{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    nixfmt-rfc-style
    nixd

    python3
    go

    ghc # Haskell

    nim-unwrapped-2_0

    nodejs_24

    # CPP
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
    libgcc
    gcc
    gnumake
    gdb
    gmp # GNU multiple precision arithmetic library
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"]; # Vimjoyer says I need it for the flake
}

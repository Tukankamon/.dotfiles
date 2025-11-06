{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    nixfmt-rfc-style
    nixd

    python3
    python313Packages.networkx

    rustc
    cargo
    rust-analyzer

    go

    ghc #Haskell

    nim-unwrapped-2_0

    nodejs_24

    /*
    CPP
    */
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
    gdb
    gmp # GNU multiple precision arithmetic library
  ];
}

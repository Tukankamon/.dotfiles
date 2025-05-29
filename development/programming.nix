{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    nixfmt-rfc-style
    nixd

    python3

    rustc
    cargo
    rust-analyzer

    go

    ghc #Haskell

    nim-unwrapped-2_0

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
    libgcc # Compiler
    gcc
    gdb
  ];
}

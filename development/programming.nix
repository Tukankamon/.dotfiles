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

    ghc

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

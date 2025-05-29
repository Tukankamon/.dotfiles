{inputs, pkgs, ...}:
{


environment.systemPackages = with pkgs; [
    python3

    rustc
    cargo

    go

    ghc

    /* CPP */
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

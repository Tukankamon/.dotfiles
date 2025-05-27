{inputs, pkgs, ...}:
{


environment.systemPackages = with pkgs; [
    python3

<<<<<<< HEAD
    rustc
=======
>>>>>>> b357a12ed88d95bfa0972a29942bf05cb7cb751a
    cargo

    go

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

{
  pkgs,
  inputs,
  ...
}: {
  # Done so I dont need to run a nix flake every time I need some simple programming done
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix

    bash-language-server

    rustc
    cargo
    rust-analyzer

    alejandra
    nil
    #nixfmt-rfc-style
    #nixd

    python3
    pyright
    (python313.withPackages (pypkgs:
      with pypkgs; [
        matplotlib
        numpy
        pandas
        scikit-learn
        jupyter
      ]))

    go

    ghc # Haskell
    haskell-language-server

    #nim-unwrapped-2_0

    lua-language-server

    #nodejs_24

    # CPP
    clang-tools
    cmake
    codespell
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
    #gmp # GNU multiple precision arithmetic library
  ];
}

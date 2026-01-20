# Is on a flake online. This is not used
{
    lib,
    stdenvNoCC,
    fetchFromGitHub,
    inkscape,
    xcursorgen,
    coreutils,
    cursorColor ? "cyan",
}:
stdenvNoCC.mkDerivation {
    pname = "future-cursors";
    version = "2025-11-29";

    src = fetchFromGitHub {
        owner = "Tukankamon";
        repo = "Future-cursors";
        rev = "b4a0bee046b312d908b22c308965a286efc3c63a";
        sha256 = "sha256-1OxxSFBk0RaPeYyphscU+CXcJBjLnl38pQcdh1Jg7wk=";
    };

    # Inkscape might take a while to do its thing and throw scary errors but it should be fine
    buildInputs = [inkscape xcursorgen coreutils];

    buildPhase = ''
        patchShebangs ./build.sh
        chmod +x build.sh
        ./build.sh svg-${cursorColor}
    '';

    installPhase = ''
        runHook preInstall

        install -dm 755 $out/share/icons/future-cursors
        cp -r dist/* $out/share/icons/future-cursors

        runHook postInstall
    '';

    meta = {
        description = "X-cursor theme inspired by macOS and based on capitaine-cursors. Options are yellow, cyan, dark (grey) or fully black";
        homepage = "https://github.com/Tukankamon/Future-cursors";
        license = lib.licenses.gpl3Only;
        maintainers = with lib.maintainers; [Tukankamon];
        platforms = lib.platforms.linux;
    };
}

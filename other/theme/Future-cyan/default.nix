# Attempt of a derivation for all 3 future cursors
#TODO it is not building correctly, it should have 3 cursors
{
    lib,
    stdenvNoCC,
    fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
    pname = "future-cursors";
    version = "2016-07-16";

    src = fetchFromGitHub {
        owner = "yeyushengfan258";
        repo = "Future-cursors";
        rev = "587c14d2f5bd2dc34095a4efbb1a729eb72a1d36";
        hash = "lib.fakeSha256";
    };

    installPhase = ''
        runHook preInstall
        install -dm 755 $out/share/icons/Future-cursors
        cp -r dist/* $out/share/icons/Future-cursors
        runHook postInstall
    '';

    meta = {
        description = "X-cursor theme inspired by macOS and based on capitaine-cursors";
        homepage = "https://github.com/yeyushengfan258/Future-cursors";
        license = lib.licenses.gpl3Only;
        maintainers = with lib.maintainers; [Tukankamon];
        platforms = lib.platforms.linux;
    };
}

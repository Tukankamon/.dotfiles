{pkgs, ...}:
# From https://github.com/Tukankamon/Future-cursors
# This derivation is directly copied from there
# For the most up to date version import its flake in the github repo
let
  cursorColor = "cyan";
in {
  # Overlay so this can be reused in other parts of the config and bc why not
  nixpkgs.overlays = [
    (final: prev: {
      future = final.stdenvNoCC.mkDerivation {
        pname = "future-cursors";
        version = "2025-11-29";
        src = pkgs.fetchFromGitHub {
          owner = "Tukankamon";
          repo = "future-cursors";
          rev = "a180aa8fc48a42dff758b06c4a10aafacf1edd49";
          sha256 = "sha256-k3nD4FHKFNWwAbd4aI46HSldoqQABn0IyCcERy/b/N4=";
        };
        installPhase = ''
          runHook preInstall

          install -dm 755 $out/share/icons/future-cursors
          cp -rL dist/${cursorColor}/* $out/share/icons/future-cursors

          runHook postInstall
        '';
      };
    })
  ];
  environment.systemPackages = [pkgs.future];

  # Must also be set in the config file of the DE
  environment.variables = {
    XCURSOR_THEME = "future-cursors";
    XCURSOR_SIZE = "24";
  };
}

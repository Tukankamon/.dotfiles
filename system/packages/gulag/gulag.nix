# Remove ads and trackers from wuolah pdfs
# This is the python CLI package not the rust library
{ pkgs }:

pkgs.python3Packages.buildPythonPackage rec {
  pname = "gulagcleaner";
  version = "0.16.4";
  pyproject = true;

  src = pkgs.fetchFromGitHub {
    owner = "YM162";
    repo = "gulagcleaner";
    rev = "v${version}";
    hash = "sha256-CL+T/xny0kYkNKUDpVPz1036nbJawle8dYcChVAnnCQ=";
  };

  maturinBuildFlags = [
    "-- -p" "gulagcleaner_python"
  ];

  nativeBuildInputs = [
    pkgs.rustPlatform.cargoSetupHook
    pkgs.rustPlatform.maturinBuildHook
    pkgs.rustc
    pkgs.cargo
  ];

  buildInputs = [
    pkgs.python3
  ];

  cargoDeps = pkgs.rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  pythonImportsCheck = [ "gulagcleaner" ];
}

{
  pkgs,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "gulagcleaner";
  version = "0.16.4";

  src = fetchFromGitHub {
    owner = "YM162";
    repo = "gulagcleaner";
    rev = "v${version}";
    hash = "sha256-CL+T/xny0kYkNKUDpVPz1036nbJawle8dYcChVAnnCQ=";
  };

  nativeBuildInputs = [
    pkgs.python3
  ];
  # lock files is in gitignore upstream
  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';
}

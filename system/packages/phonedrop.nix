# https://github.com/willmanduran/phonedrop
{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "phonedrop";
      src = pkgs.fetchFromGitHub {
        owner = "willmanduran";
        repo = "phonedrop";
        rev = "f332bdd";
        sha256 = "sha256-bB4X8UTtuxph11diNgDjZcuFPoswX5UV7R0k77BGR8A=";
      };
      nativeBuildInputs = with pkgs; [
        cmake
        libx11.dev
        makeWrapper
      ]; #only buildtime deps

      buildPhase = ''
        cmake -DCMAKE_BUILD_TYPE=Release .
        make -j$(nproc)
      '';
      installPhase = ''
        mkdir -p $out/bin
        cp phonedrop $out/bin/

        # Does not follow unix convention
        # Supposed to fix the site not loading properly but doesnt work
        cp -r $src/web $out/bin/
        cp -r $src/assets $out/bin/
      '';
      postFixup = ''
        wrapProgram $out/bin/phonedrop \
          --prefix PATH : ${pkgs.lib.makeBinPath [pkgs.zenity]} \
          --run 'cd $out/bin' # Not ideal
      ''; # Allows zenity to be in the path at runtime for the gui and pop ups
    })
  ];

  networking.firewall = {
    # Default port for the program
    #TODO find way to dynamically open the port
    allowedTCPPorts = [9877];
  };
}

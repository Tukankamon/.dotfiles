{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.ollama = {
    enable = lib.mkEnableOption " Enable or disable ollama and accesories";
    # Maybe make option to add or not additional scripts
  };

  config = lib.mkIf config.modules.ollama.enable {
    environment.systemPackages = [
      pkgs.ollama

      # Script that gives ollama context by catting out every nix file down subdirectories
      (pkgs.writeShellScriptBin "wrapollama" (builtins.readFile ./wrapollama.sh))
    ];

    services.ollama = {
      enable = true;
      loadModels = [];
    };
  };
}

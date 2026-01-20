{pkgs, ...}:
{
    environment.systemPackages = [
        pkgs.ollama

        # Script that gives ollama context by catting out every nix file down subdirectories
        (pkgs.writeShellScriptBin "wrapollama" (builtins.readFile ./wrapollama.sh))
    ];

    services.ollama = {
        enable = true;
        loadModels = [];
    };
}

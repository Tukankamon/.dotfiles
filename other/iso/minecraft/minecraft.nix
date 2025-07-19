{ pkgs, lib, ...}:

{
  services.minecraft = {
        enable = true;
        eula = true;
        declarative = true;
        package = pkgs.minecraft-server-1-16;

        serverProperties = {
          gamemode = "survival";
          difficulty = "hard";
          simulation-distance = 10;  #I think this is chunk render distance
        };
  };
}

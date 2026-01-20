{
  pkgs,
  lib,
  ...
}: {
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    package = pkgs.minecraftServers.vanilla-1-16;

    serverProperties = {
      gamemode = "survival";
      difficulty = "hard";
      simulation-distance = 10; # I think this is chunk render distance
      motd = "Minecraft TuKa";
      online-mode = false;
      #"server-icon" = ....   #Idk if this works
    };
  };
}

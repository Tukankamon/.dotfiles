{ pkgs, config, lib, ...}:
{
  options.modules.gaming = {
    enable = lib.mkEnableOption "Enable or disable gamin suite";
  };

  config = lib.mkIf config.modules.gaming.enable {

    programs = {
      steam = {
        #Unfree, the package is listed as allowed in sysPackages to keep them all
        # in one list
        enable = true;
        package = pkgs.steam.override {
          extraPkgs = pkgs:
            with pkgs; [
              gamescope
            ];
        };
      };

      # Doesnt work currently
      gamescope = {
        enable = false;
        capSysNice = true; # "overclocks" the CPU
      };

      gamemode = {
        enable = true;
        settings = { # Find a way to enable this only if modules.amd.enable is true
          #gpu.amd_performance_level = "high"; # Haven't tested this
        };
      };
    };

    environment.systemPackages = [
      pkgs.mangohud
      pkgs.prismlauncher # Minecraft
      #pkgs.heroic

      # Fps overlay (add mangohud %command% to steam launch options in the game)
      pkgs.mangohud
      pkgs.xonotic # FOSS quake-like game
    ];
  };
}

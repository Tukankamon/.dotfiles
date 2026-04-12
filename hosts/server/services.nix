{pkgs, ...}: let
  ip = "192.168.1.65";
  #ip = "ekko"; # Defined in configuration.nix
in {
  #services.displayManager.ly.enable = true; # login manager (broken)

  services.logind.settings.Login = {
    # keep running when lid closed
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  services.prometheus = {
    # Server monitoring (not a dashboard)
    enable = false;
    exporters.node = {
      enable = true;
      port = 9100;
      enabledCollectors = [
        "systemd"
        "processes"
      ]; # TODO add more
      openFirewall = true; # true when you want it on lan
    };
    scrapeConfigs = [
      {
        job_name = "local-node";
        static_configs = [{targets = ["localhost:9100"];}];
      }
    ];
  };

  services.grafana = {
    # prometheus dashboard
    enable = false;
    settings.server = {
      http_addr = "0.0.0.0";
      http_port = 3000;
    };
  };

  services.cgit.main = {
    #TODO make it pretty
    enable = false;
    #scanPath = "/var/lib/git";
    group = "git";
    settings = {
      repository-sort = "age";
      "repo.defbranch" = "main";
      scan-hidden-path = true;
      scan-tree = "/var/lib/git";
      root-title = "Ekko git server";
      root-desc = "Git backups and projects not worthy of Codeberg";
      "options.enable-git-config" = 1; # Ai says I need it
    };
    gitHttpBackend = {
      enable = true;
      checkExportOkFiles = false; #IDk what this does
    };
    repos.".dotfiles" = {
      desc = "My NixOs dotfiles";
      path = "/var/lib/git/.dotfiles";
    };
    repos.serverDots = {
      desc = "Dotfiles for a NixOs home server";
      path = "/var/lib/git/serverDots";
    };
  };

  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    settings = {
      server = {
        DOMAIN = "${ip}";
        HTTP_PORT = 3001;
        HTTP_ADDR = "0.0.0.0";
        SSH_PORT = 22;
      };
      repository = {
        DEFAULT_BRANCH = "main";
      };

      ui.DEFAULT_THEME = "arc-green";
    };
  };

  services.minecraft-server = {
    #Untested
    enable = false;
    eula = true;
    declarative = true;
    openFirewall = true;
    package = pkgs.minecraftServers.vanilla-1-16;
    serverProperties = {
      gamemode = "survival";
      difficulty = "hard";
      simulation-distance = 10;
      motd = "Ekko minecraft";
      #online-mode = false; #I think this enables cracked
      #server-icon = ...
    };
  };

  #8096
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "aved";
    group = "users";
  };

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    webuiPort = 8081; # 8080 taken by dashboard
  };

  services.glance = {
    # Dashboard, maybe just move this to yaml cuz this is messy
    enable = true;
    openFirewall = true;
    settings.server = {
      "host" = ""; # kept overriding the port
      "listen-address" = "0.0.0.0";
      "port" = 8080;
    };
    settings.pages = [
      {
        name = "Dashboard";
        columns = [
          {
            size = "small";
            widgets = [
              {type = "calendar";}
              {
                type = "weather";
                location = "Seville";
                unit = "metric";
              }
            ];
          }
          {
            size = "full";
            widgets = [
              {
                type = "monitor";
                title = "Ekko server";
                sites = [
                  {
                    title = "Git";
                    url = "http://${ip}";
                    icon = "si:git"; #Todo customize this
                  }
                  {
                    title = "Jellyfin";
                    url = "http://${ip}:8096";
                    icon = "si:jellyfin";
                  }
                  {
                    title = "qBittorrent";
                    url = "http://${ip}:8081";
                    icon = "si:qbittorrent";
                  }
                  {
                    title = "Minecraft";
                    url = "http://${ip}:25565";
                    icon = "si:minecraft";
                  }
                  {
                    title = "Grafana";
                    url = "http://${ip}:3000";
                    icon = "si:grafana";
                  }
                ];
              }
            ];
          }
        ];
      }
    ];
  };
}

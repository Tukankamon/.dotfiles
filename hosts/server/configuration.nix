{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./services.nix
    ./packages.nix
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.variables.EDITOR = "nvim";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false; # Only allow ssh, no passwd
      AllowUsers = ["aved" "git"];
    };
  };

  networking.extraHosts = ''
    192.168.0.185 dwebble
    192.168.0.186 yamask
  '';
  networking.hostName = "ekko"; # Define your hostname.
  networking.firewall.allowedTCPPorts = [
    22
    3000
    3001
    9090
    9100
  ];
  # 22 -> ssh
  # 3000 -> graphana (metrics dashboard)
  # 3001 -> forgejo
  # 9090 -> prometheus (metrics)
  # 9100 -> prometheus node exporter

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_ES.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  console.keyMap = "es";
  services.xserver.xkb = {
    layout = "es";
    variant = "";
    options = "caps:escape";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.git = {};
  users.users = {
    aved = {
      isNormalUser = true;
      description = "idk";
      extraGroups = [
        "networkmanager"
        "wheel"
        "qbittorrent"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAFSqTtvNicN6FImEm0yz5WKvZk5RtJbPE1lnf7XlG7f aved@yamask"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7fy8K9yE7U+MPNOT6ZG5jkYHNCQfbyXRCd+evpC4mK aved@dwebble"
      ];
    };
    git = {
      # For the git hosting
      isSystemUser = true;
      group = "git";
      home = "/var/lib/git";
      createHome = true;
      shell = "${pkgs.git}/bin/git-shell";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAFSqTtvNicN6FImEm0yz5WKvZk5RtJbPE1lnf7XlG7f aved@yamask"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7fy8K9yE7U+MPNOT6ZG5jkYHNCQfbyXRCd+evpC4mK aved@dwebble"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtxk0Q7sbIydvD557rRiwpfQTQVxG4Ie9TOReajT+hF aved@ekko"
      ];
    };
  };

  /*
  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["aved"];
          persist = true;
        }
      ];
    };
    sudo.enable = false;
  };
  */

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}

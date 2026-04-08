{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.users;
in {
  options.modules.users = {
    enable = lib.mkEnableOption "User configuration" // {default = true;};

    username = lib.mkOption {
      type = lib.types.str;
      default = "aved";
      description = "Username for the main user";
    };

    shell = lib.mkOption {
      type = lib.types.str;
      default = "fish";
      description = "Default shell in terminals";
    };

    otherGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Extra groups to add to the user (important groups are already there";
    };
  };

  config = let
    shellPkg = pkgs.${cfg.shell};
  in
    lib.mkIf cfg.enable {
      # Set the password using the passwd command. That way it is not stored inside of the config file
      # If you still want it to be declarative, hash it with mkpasswd and set it below
      #hashedPassword = "";
      users.users.${cfg.username} = {
        isNormalUser = true;
        description = cfg.username;
        extraGroups =
          [
            "networkmanager"
            "wheel"
            "adbusers"
            "dialout" # For arduino and stuff
            "vboxusers"
          ]
          ++ cfg.otherGroups;
      };

      environment.shells = [shellPkg];
      users.defaultUserShell = shellPkg;
      # This option could not exist
      programs.${cfg.shell}.enable = true;
    };
}

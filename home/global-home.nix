{
  # inputs,
  # config,
  # pkgs,
  # lib,
  ...
}:

{
  imports = [
    ./programs/kitty.nix
    ./programs/fastfetch.nix
    ./deskenv/desk-module.nix
    ./programs/nvim.nix
    ./programs/misc.nix
  ];

  programs.bash = {
    enable = false;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd .."; # Shortcuts
    };
  };

  programs.git = {
    enable = true;
    userName = "TuKankamon";
    userEmail = "antovedaros@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      #safe.directory = "/etc/nixos";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ]; #changes the cd to zoxide
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

{
  # inputs,
  # config,
  # pkgs,
  # lib,
  ...
}:

{
  imports = [
    ./kitty.nix
    ./fastfetch.nix
    ./deskenv/desk-module.nix
    ./nvim.nix
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


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

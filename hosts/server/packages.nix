{
  pkgs,
  lib,
  ...
}: {
  imports = [../../system/packages/scripts];
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    gcc
    vim
    neovim
    git
    fastfetch
    pipes
    lf
    yazi
    fzf
    ripgrep
    fd
    eza
    parted
    htop
    hyperfine
    zoxide
    dysk
    nvd
    alejandra
    tmux
    dotter #manage dotfiles
    tree-sitter
  ];

  nixpkgs.config.allowUnfreePredicate = pkgs:
    builtins.elem (lib.getName pkgs) [
      "minecraft-server"
    ];
}

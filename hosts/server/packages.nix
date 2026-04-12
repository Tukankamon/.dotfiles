{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      nxs = "doas nixos-rebuild switch --flake ~/.dotfiles#ekko";
      nxgc = "nix-store --gc && nix-collect-garbage -d && doas nix-collect-garbage -d";
    };
  };
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    vim
    git
    fastfetch
    pipes
    lf
    fzf
    ripgrep
    parted
    htop
    hyperfine
    zoxide
    dysk
    nvd
    alejandra
    tmux
    dotter #manage dotfiles
  ];

  nixpkgs.config.allowUnfreePredicate = pkgs:
    builtins.elem (lib.getName pkgs) [
      "minecraft-server"
    ];
}

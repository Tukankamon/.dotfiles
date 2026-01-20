{pkgs, ...}: {
  imports = [
    ./../home/globalHome.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  desktopHome = "niri";

  home.packages = with pkgs; [
    hello
  ];
  fonts.fontconfig.enable = true;

  home.file = {
  };

  home.sessionVariables = {
    #EDITOR = "vscodium";
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    #shellInit =  "fastfetch";

    shellAbbrs = {
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles#dwebble";
      hms = "home-manager switch --flake ~/.dotfiles#dwebble";

      nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      #Maybe find a way to index e.g: automated-commit-1
    };

    functions = {
      #fish_prompt = "string join '' (set_color green) (prompt_pwd --full-length-dirs 3) (set_color normal) '~>'";
    };
  };
}

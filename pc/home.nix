{...}: {
  imports = [
    ./../home/globalHome.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  desktopHome = ["niri" "gnome"];

  fonts.fontconfig.enable = true;

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting

    '';

    shellAbbrs = {
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles#yamask";
      hms = "home-manager switch --flake ~/.dotfiles#yamask";

      nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
    };

    functions = {
      #fish_prompt = "string join '' (set_color green) (prompt_pwd --full-length-dirs 3) (set_color normal) '~>'";
    };
  };
}

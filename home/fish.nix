# Hostname is a variable declared in the flake
{hostname, ...}: {
  programs.fish = {
    enable = true;
    /*
       Cntrl Delet doesnt work and that is a deal breaker
    shellInit =  ''
      fish_vi_key_bindings --no-erase
    '';
    */

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    functions = {
      # As seen in https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
      y = {
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          command yazi $argv --cwd-file="$tmp"
          if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
      /*
         doesnt work
      cd = {
      	body = ''builtin cd $argv && ls'';
      };
      */
    };

    shellAbbrs = {
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles#${hostname}";
      hms = "home-manager switch --flake ~/.dotfiles#${hostname}";
    };

    shellAliases = {
      # Eza needs to be installed ofc
      ls = "eza --icons";
      ll = "eza -l --time-style=relative --no-permissions --no-user --icons";
      la = "eza -la --time-style=relative --no-permissions --no-user --icons";

      # Lists all installed packages (including dependencies
      nxls = "nix-store --query --requisites /run/current-system";
      nxgc = "nix-store --gc && nix-collect-garbage -d && sudo nix-collect-garbage -d";

      vim = "nvim";
      vi = "nvim";

      ta = "tmux attach";
      tl = "tmux ls";
    };
  };
}

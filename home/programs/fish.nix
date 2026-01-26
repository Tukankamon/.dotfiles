{...}: {
  # There are shell aliases that are dependent on the host so there is
  # Another programs.fish in each host/home.nix
  # This is also where the programs is enabled
  programs.fish = {
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
    };

    # More in host/home.nix
    shellAbbrs = {
      nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
    };

    shellAliases = {
      # Eza needs to be installed ofc
      ls = "eza --icons";
      ll = "eza -l --time-style=relative --no-permissions --no-user --icons";
      la = "eza -la --time-style=relative --no-permissions --no-user --icons";

      # Lists all installed packages (including dependencies
      nxls = "nix-store --query --requisites /run/current-system";
    };
  };
}

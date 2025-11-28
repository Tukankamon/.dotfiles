{
    pkgs,
    inputs,
    lib,
    config,
    ...
}: {
    imports = [
        ./../home/global-home.nix
    ];

    home.username = "aved";
    home.homeDirectory = "/home/aved";

    home.stateVersion = "24.11"; # Please read the comment before changing.

    /*
    specialisation.gnome.configuration = {
        gnome-home.enable = true; #TODO make this an option with a string value like the one in configuration.nix
    };
    */ # Broken

    # Will only build if not in the gnome specialisation
    #niriHome.enable = config.specialisation == {};
    niriHome.enable = true;

    home.packages = with pkgs; [
        hello
    ];

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
            nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles/pc#yamask";
            hms = "home-manager switch --flake ~/.dotfiles/pc#yamask";

            nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
        };

        functions = {
            #fish_prompt = "string join '' (set_color green) (prompt_pwd --full-length-dirs 3) (set_color normal) '~>'";
        };
    };
}

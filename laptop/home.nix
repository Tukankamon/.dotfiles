{pkgs, ...}: {
    imports = [
        ./../home/global-home.nix
    ];

    home.username = "aved";
    home.homeDirectory = "/home/aved";

    home.stateVersion = "24.11"; # Please read the comment before changing.

    gnome-home.enable = true; # Dont forget to also disable it in configuration.nix
    hypr-home.enable = false; # Same thing here

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
            nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles/laptop#dwebble";
            hms = "home-manager switch --flake ~/.dotfiles/laptop#dwebble";
            nxshell = "nix-shell ~/.dotfiles/development/shell.nix";

            nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
            lx = "hx";
            #Maybe find a way to index e.g: automated-commit-1
        };
    };
}

{pkgs, ...}:
    let 
        future-cursors = pkgs.callPackage ./../system/default.nix {};
in {
    imports = [
        ./programs/kitty.nix
        ./programs/fastfetch.nix
        ./deskenv/desktopHomeBundle.nix
        ./programs/nvim.nix
        ./programs/misc.nix
    ];



    home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = future-cursors;
        name = "Future-cursors";
    };

    programs.bash = {
        enable = false;
        shellAliases = {
            ll = "ls -l";
            ".." = "cd .."; # Shortcuts
        };
    };

    programs.git = {
        enable = true;
        settings = {
            # Change this accordingly
            init.defaultBranch = "main";
            user.name = "TuKankamon";
            # Github private email
            user.email = "198082906+Tukankamon@users.noreply.github.com";
        };
    };

    programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = ["--cmd cd"]; # changes the cd to zoxide
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

{
  config,
  lib,
  ...
}: {
  options.gnomeHome = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "Enables the gnome desktop environment home configurations";
  };

  config = lib.mkIf config.gnomeHome {
    home.packages = [
      # Installed on system level (extensions too)
    ];

    gtk = {
      #IDK if this works
      enable = true;
      #gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      #gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
      cursorTheme.name = "Future-cyan-cursors"; # folder needs to be in .local/share/icons
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";

        "org/gnome/desktop/background" = {
          picture-uri-dark = "file://" + ./../../other/images/roadwp.jpg;
        };

        "org/gnome/shell" = {
          disable-user-extensions = false;

          enabled-extensions = [
            "blur-my-shell@aunetx"
            "gsconnect@andyholmes.github.io"
            "appindicatorsupport@rgcjonas.gmail.com" # Dont know if this is right
          ];
        };

        "org/gnome/shell/extensions/blur-my-shell" = {
          #enabled = true;
          "blacklist" = "@as []";
          "blur-on-overview" = false;
          "brightness" = "1.0";
          "customize" = true;
          "enable-all" = true;
          "opacity" = "250";
          "sigma" = "59";
          "blur" = true;
        };

        "org/gnome/shell/app-switcher".current-workspace-only = true;
        "org/gnome/desktop/interface".enable-hot-corners = false;

        /*
          "org/gnome/shell/extensions/auto-move-windows" = {
            "application-list" = [
                "brave-browser.desktop:1"
                "librewolf.desktop:1"
                "obsidian.desktop:2"
                "codium.desktop:3"
                "steam.desktop:3"
                "discord.desktop:4"
                "spotify.desktop:5"
                "mullvad-browser.desktop:5"
            ];
        };
        */

        "org/gnome/mutter".dynamic-workspaces = false;
        "org/gnome/desktop/wm/preferences".num-workspaces = 7;
        "org/gnome/desktop/wm/keybindings" = {
          close = ["<Alt>p"];

          switch-to-workspace-1 = ["<Alt>1"];
          switch-to-workspace-2 = ["<Alt>2"];
          switch-to-workspace-3 = ["<Alt>3"];
          switch-to-workspace-4 = ["<Alt>4"];
          switch-to-workspace-5 = ["<Alt>5"];
          switch-to-workspace-6 = ["<Alt>6"];
          switch-to-workspace-7 = ["<Alt>7"];

          move-to-workspace-1 = ["<Alt><Shift>1"];
          move-to-workspace-2 = ["<Alt><Shift>2"];
          move-to-workspace-3 = ["<Alt><Shift>3"];
          move-to-workspace-4 = ["<Alt><Shift>4"];
          move-to-workspace-5 = ["<Alt><Shift>5"];
          move-to-workspace-6 = ["<Alt><Shift>6"];
          move-to-workspace-7 = ["<Alt><Shift>7"];
        };

        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
          speed = 0.20;
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          #accel-profile = "flat";
          speed = 0.25;
        };
      };
    };
  };
}

{...}: {
  programs.fastfetch = {
    # Looks hella ugly now, gotta fix that
    enable = true; # using stylix now
    settings = {
      schema = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = ""; # default size
        color = {
          "1" = "38;2;198;148;255";
        }; # (turns the dark blue to purpleish)
        #color = {"2" = "38;2;198;148;255";};  #(turns the light blue to purpleish)
        padding = {
          top = 2;
          right = 6;
        };
      };
      display = {
        #size = {
        #binaryPrefix = "si";
        #};
        #color = "blue";
        separator = " ";
      };
      modules = [
        "break"
        "break"
        {
          type = "title"; # types "host"@"user"
          keyWidth = 10;
        }
        "break"
        {
          type = "os";
          key = ""; # Uses "" but it doesnt seem to work
          keyColor = "38;2;198;148;255"; # 33 is kinda orange
        }
        {
          type = "kernel";
          key = "";
          keyColor = "38;2;198;148;255";
        }
        {
          type = "gpu";
          key = "";
          keyColor = "38;2;198;148;255";
        }
        {
          type = "packages";
          format = "{} (Nix)";
          key = "";
          keyColor = "38;2;198;148;255";
        }
        {
          type = "shell";
          key = "";
          keyColor = "38;2;198;148;255";
        }
        {
          type = "terminal";
          key = "";
          keyColor = "38;2;198;148;255";
        }
        {
          type = "wm";
          key = "";
          keyColor = "38;2;198;148;255";
        }
        {
          type = "uptime";
          key = "";
          keyColor = "38;2;198;148;255";
        }
        {
          type = "custom";
          key = "Made ya look";
          keyColor = "38;2;198;148;255";
        }
        "break"
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
        "break"
        "colors"
        "break"
        "break"

        /*
        "break"			(these came by default)
        "player"
        "media"
        */
      ];
    };
  };
}

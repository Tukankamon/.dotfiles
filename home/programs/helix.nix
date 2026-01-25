# Currently not imported anywhere
{pkgs, ...}: {
  programs.helix = {
    enable = false; # messes up muscle memory
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
      }
    ];
    themes = {
      catppuccin_mocha = {
        "inherits" = "catpuccin_mocha";
        "ui.background" = {};
      };
    };
  };
}

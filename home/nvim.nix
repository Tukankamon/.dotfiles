{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = [];

    #vimrc config
    extraConfig = ''
      set relativenumber
      set autoindent
      set mouse=a
      noremap <Ctrl-n> :Neotree<Cr>
    '';

    extraLuaConfig = ''
      vim.opt.tabstop = 4
    '';
  };

  programs.nvf = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "nord";
        style = "dark";
      };

      filetree.neo-tree.enable = true;
      statusline.lualine.enable = true; #IDK what this does
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      lsp.enable = true;
      lsp.servers = {};

      languages = {
        enableFormat = true;
        enableTreesitter = true;

        nix = {
          enable = true;
          lsp.enable = true;
          lsp.server = "nixd";
          format.enable = true;
          format.type = "alejandra";
        };

        python = {
          enable = true;
          lsp.enable = true;
        };
        clang.enable = true;
        rust.enable = true;
        go.enable = true;
      };
    };
  };

  programs.helix = {
    enable = true;
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

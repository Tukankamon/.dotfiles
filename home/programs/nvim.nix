{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.neovim = {
    enable = false; # nvf does the work

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
      globals = {
        mapLeader = " ";
        vim.globals.maplocalleader = " ";
      };

      #autopairs.nvim-autopairs.enable = true;
      options.tabstop = 4;
      options.shiftwidth = 0; # Uses tabstop value

      theme = {
        #Already set with stylix
        enable = true;
        name = "nord";
        style = "dark";
      };

      filetree.neo-tree.enable = true;
      statusline.lualine.enable = true; # IDK what this does
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      languages = {
        bash.lsp.enable = true;
        clang.lsp.enable = true;
        nix.lsp.enable = true;
        python.lsp.enable = true;
      };
    };
  };

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

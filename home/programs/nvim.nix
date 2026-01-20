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
      noremap j gj
      noremap g gk

      " Yank to system clipboard
      set clipboard=unnamed

      " Doesnt work
      exmap surround_wiki surround [[ ]]
      exmap surround_double_quotes surround " "
      exmap surround_single_quotes surround ' '
      exmap surround_backticks surround ` `
      exmap surround_brackets surround ( )
      exmap surround_square_brackets surround [ ]
      exmap surround_curly_brackets surround { }
      exmap surround_equals surround == ==
      exmap surround_italics surround __ __
      exmap surround_bold surround ** **

      " NOTE: must use 'map' and not 'nmap'
      map [[ :surround_wiki<CR>
      nunmap s
      vunmap s
      map s" :surround_double_quotes<CR>
      map s' :surround_single_quotes<CR>
      map s` :surround_backticks<CR>
      map sb :surround_brackets<CR>
      map s( :surround_brackets<CR>
      map s) :surround_brackets<CR>
      map s[ :surround_square_brackets<CR>
      map s] :surround_square_brackets<CR>
      map s{ :surround_curly_brackets<CR>
      map s} :surround_curly_brackets<CR>
      map s= :surround_equals<CR>
      map s_ :surround_italics<CR>
      map s* :surround_bold<CR>
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

      # Doesnt work
      #startPlugins = [ "obsidian-nvim" ];

      #autopairs.nvim-autopairs.enable = true;
      options.tabstop = 4;
      options.shiftwidth = 0; # Uses tabstop value

      theme = {
        #Already set with stylix
        enable = true;
        name = "nord";
        style = "dark";
      };

      #filetree.neo-tree.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      lsp.enable = true;
      languages = {
        enableTreesitter = true;
        enableFormat = true;

        bash.enable = true;
        clang.enable = true;
        nix.enable = true;
        python.enable = true;
        markdown.enable = true;
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

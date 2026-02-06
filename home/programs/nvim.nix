{inputs, pkgs, ...}: {
  # Ideas for configuration: https://github.com/NotAShelf/nvf (in configuration.nix)
  imports = [inputs.nvf.homeManagerModules.default];

  # Nvim configuration
  programs.nvf = {
    enable = true;

    settings.vim = {
      globals = {
        mapLeader = " ";
        vim.globals.maplocalleader = " ";
        vim_markdown_folding_disable = 1; # For the obsidian plugins
      };

      keymaps = [
        {
          key = "j";
          mode = "n";
          action = "gj";
          silent = true;
        }
        {
          key = "k";
          mode = "n";
          action = "gk";
          silent = true;
        }
        {
          key = "<C-BS>";
          mode = "i";
          action = "<C-w>";
          silent = true;
        }
      ];

      #autopairs.nvim-autopairs.enable = true;
      options.tabstop = 2;
      options.shiftwidth = 0; # Uses tabstop value
      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
      };

      theme = {
        enable = true;
        name = "everforest";
        style = "hard";
        transparent = false; # Too distracting
      };

      # Installs some git related plugins
      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      # I like how render-markdown-nvim works
      notes.obsidian = {
        enable = false;
        setupOpts = {
          legacy_commands = false;
          dir = "~/obsidian/original_vault_name";
          completion.nvim_cmp = true;
        };
      };

      #filetree.neo-tree.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      treesitter = {
        enable = true;
        /*
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          markdown
          latex
        ];
        */
      };

      lsp.enable = true;
      languages = {
        enableTreesitter = true;
        enableFormat = true;

        bash.enable = true;
        clang.enable = true;
        nix.enable = true;
        python.enable = true;
        haskell.enable = true; #BROKEN
        markdown = {
          enable = true;
          extensions.render-markdown-nvim = {
            enable = true;
            setupOpts.latex.enabled = true;
          };
        };
        #css.enable = true;
      };
    };
  };
}

{inputs, ...}: {
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
      ];
      # Needs to be downloaded from the flake
      #startPlugins = [ "obsidian-nvim" ];

      #autopairs.nvim-autopairs.enable = true;
      options.tabstop = 2;
      options.shiftwidth = 0; # Uses tabstop value
      clipboard = {
      	enable = true;
	providers.wl-copy.enable = true;
	registers = "unnamedplus";
      };

      theme = {
        enable = true;
        name = "nord";
        style = "dark";
      };

      # Installs some git related plugins
      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      /*
         BROKEN
      notes.obsidian = {
        enable = true;
      };
      */

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
        #css.enable = true;
      };
    };
  };
}

{inputs, ...}: {
  # Ideas for configuration: https://github.com/NotAShelf/nvf (in configuration.nix)
	# Needs to be inported in the flake
	#imports = [inputs.nvf.homeManagerModules.default];

  # Nvim configuration
  programs.nvf = {
    enable = false;
    settings.vim = {
      
      # Separate lua file to start migrating away from nvf and home manager
      # to make the configuration more protable
			#luaConfigRC.myConfig = builtins.readFile ./init.lua;

      #autopairs.nvim-autopairs.enable = true;
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
        rust.enable = true;
        haskell.enable = true;
        lua.enable = true;
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

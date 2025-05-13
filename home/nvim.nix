{ inputs, pkgs, lib, config, ...}:

{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.neovim = {
    enable = true;
    
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = [];

    #vimrc config
    extraConfig = ''
      set relativenumber
      set tabstop=1
      set autoindent
      set mouse=a
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


    statusline.lualine.enable = true; #IDK what this does
    telescope.enable = true;

    lsp.enable = true;

    languages = {
      enableTreesitter = true;

      nix = {
        enable = true;
        format.type = "alejandra";
      };

      python.enable = true;
    };
  };
  };

}

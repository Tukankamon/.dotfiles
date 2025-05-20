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
    };
  };
  };
}

{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./kitty.nix 
    ./fastfetch.nix
    ./../deskenv/desk-module.nix
  ];

  programs.bash = {
    enable = false;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";		#Shortcuts
    };
  };
  
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting

    '';

    #shellInit =  "fastfetch";

    shellAbbrs = {
      nxs  = "sudo nixos-rebuild switch --flake ~/.dotfiles/laptop";
      hms = "home-manager switch --flake ~/.dotfiles/laptop";
      nxgc = "nix-collect-garbage -d && nix-collect-garbage && sudo nix-collect-garbage -d";
  };
};
  
   programs.git = {
     enable = true;
     userName = "TuKankamon";
     userEmail = "antovedaros@gmail.com";
     extraConfig = {
       init.defaultBranch = "main";
     #safe.directory = "/etc/nixos";
   };
  };
  
   programs.neovim = {
	enable = false;
	defaultEditor = true;
	viAlias = true;
	vimAlias = true;
	extraConfig = ''
		set number relativenumber
		set tabstop=8
		set autoindent
		set mouse=a
		colorscheme slate
	  '';
	plugins = with pkgs.vimPlugins; [
		nvim-lspconfig
		vim-nerdtree-tabs
		nvim-treesitter.withAllGrammars
		plenary-nvim
		mini-nvim
	];	

	};	

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
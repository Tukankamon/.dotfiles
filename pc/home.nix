{ inputs, config, pkgs, lib, ... }:

{

  imports = [ 
    ./../konfig/kitty.nix 
    ./../konfig/fastfetch.nix
    ./../konfig/deskenv/desk-module.nix
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  gnome.enable = true;    #Dont forget to also disable it in configuration.nix
  hypr.enable = false;    #Same thing here

  home.packages = with pkgs; [
    pkgs.hello
  ];
  fonts.fontconfig.enable = true;

  home.file = {

  };

  home.sessionVariables = {
    #EDITOR = "vscodium";
  };
  
  
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
      nxs  = "sudo nixos-rebuild switch --flake ~/.dotfiles/pc";
      hms = "home-manager switch --flake ~/.dotfiles/pc";

      nix-clean =  "sudo nix-collect-garbage -d";
      home-clean = "home-manager expire-generations -d";
      nix-orphans = "nix store gc &&  sudo nix store optimize";
      nix-wipe  = "sudo nix profile wipe-history";
      hm-clean-old = "home-manager remove-generations old";
      nix-system-clean = "nix-clean && home-clean && nix-orphans && nix-wipe && hm-clean-old && nix-collect-garbage -d";
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

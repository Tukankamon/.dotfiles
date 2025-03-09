{ config, pkgs, lib, ... }:

{

  imports = [ 
    ./konfig/kitty.nix 
    ./konfig/fastfetch.nix
    ./konfig/gnome.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "aved";
  home.homeDirectory = "/home/aved";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.


  home.packages = [

    pkgs.hello
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/aved/etc/profile.d/hm-session-vars.sh
  #
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

    shellInit =  "fastfetch";

    shellAbbrs = {
      nxs  = "sudo nixos-rebuild switch --flake .";
      hms = "home-manager switch --flake .";

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
	enable = true;
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

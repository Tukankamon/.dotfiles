{ config, pkgs, ... }:

{
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
    # EDITOR = "emacs";
  };
  
  
  programs.bash = {
    enable = false;	#For home-manager configs
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";		#Shortcuts
    };
  };
  
  programs.fish = {
    enable = true;
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
  
  
  programs.fastfetch = {		#Looks hella ugly now, gotta fix that
    enable = false;   #using stylix now	
    settings = {
      schema = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "";	#default size
        #color = {"1" = "red";};  #(turns the light blue to red)
        padding = {
          top = 2;
          right = 6;
      };
    };
    display = {
      #size = {
        #binaryPrefix = "si";
      #};
      #color = "blue";
      separator = " ";
    };
    modules = [
      "break"
      "break"
      {
        type = "title";		#types "host"@"user"
        keyWidth = 10;
      }
      "break"
      {
        type = "os";
        key = "";		#Uses "" but it doesnt seem to work
        keyColor = "38;2;185;95;137";	#33 is kinda orange
      }
      {
        type = "kernel";
        key = "";
        keyColor = "38;2;185;95;137";
      }
      {
        type = "packages";
        format = "{} (Nix)";
        key = "";
        keyColor = "38;2;185;95;137";
      }
      {
        type = "shell";
        key = "";
        keyColor = "38;2;185;95;137";
      }
      {
        type = "terminal";
        key = "";
        keyColor = "38;2;185;95;137";
      }
      {
        type = "wm";
        key = "";
        keyColor = "38;2;185;95;137";
      }
      {
        type = "uptime";
        key = "";
        keyColor = "38;2;185;95;137";
      }
      {
        type = "custom";
        key = "Made ya look";
        keyColor = "38;2;185;95;137";
      }
      "break"
      {
        type = "datetime";
        key = "Date";
        format = "{1}-{3}-{11}";
      }
      {
        type = "datetime";
        key = "Time";
        format = "{14}:{17}:{20}";
      }
      "break"
      "colors"
      "break"
      "break"
      
      
      /*"break"			(these came by default)
      "player"
      "media"
      */
    ];
  };
  };
  
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    /*scrollback_lines = 10000;
    enable_audio_bell = false;
    update_check_interval = 0;*/		#Example config
    

    #look for wryan kitty theme or Base2Tone
    extraConfig = ''  
    font_family FiraCode Nerd Font Mono

    hide_window_decorations titlebar-only

    foreground #f8f8f2
    background #000000
    url_color #0087bd
    url_style curly
  
    background_opacity 0.9
    background_blur 1
    '';
    
  };
  
  
  
  /*wayland.windowManager.hyprland = {
  	enable = false; 	#Enables hyprland 
  	
  	plugins = [
  	  inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
  	  ];
  	
  	settings = {
  	  "plugins:borders-plus-plus" = {
  	    add_borders = 1;	#0-9
  	    
  	    "col.border_1" = "rgb(ffffff)";	#Up to 9 borders
  	    "col.border_2" = "rgb(2222ff)";
  	    
  	    border_size_1 = 10;
  	    border_size_2 = -1;		#-1 = default
  	    
  	    natural_rounding = "yes";
  	};
  };
  };*/
  	


  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      
      "org/gnome/shell" = {
        disable-user-extensions = false;
        /*enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell
        ];*/
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        #enabled = true;
        "blacklist"="@as []";
	      "blur-on-overview"=false;
	      "brightness"="1.0";
	      "customize"=true;
	      "enable-all"=true;
	      "opacity"="250";
	      "sigma"="59";
	      "blur"=true;
      };

    };
  };
  

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

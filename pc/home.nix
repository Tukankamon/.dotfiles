{
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    ./../home/global-home.nix
    inputs.zen-browser.homeModules.beta
  ];

  home.username = "aved";
  home.homeDirectory = "/home/aved";

  home.stateVersion = "24.11"; # Please read the comment before changing.


  gnome.enable = true; 
  hypr.enable = false;

  home.packages = with pkgs; [
    hello
  ];
  fonts.fontconfig.enable = true;

  home.file = {

  };

  home.sessionVariables = {
    #EDITOR = "vscodium";
  };

  programs.zen-browser = {  #https://github.com/luisnquin/nixos-config/blob/main/home/modules/browser.nix
    enable = true;
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true; # save webs for later reading
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting

    '';

    #shellInit =  "fastfetch";

    shellAbbrs = {
      nxs = "sudo nixos-rebuild switch --flake ~/.dotfiles/pc#yamask";
      hms = "home-manager switch --flake ~/.dotfiles/pc#yamask";
      nxshell = "nix-shell ~/.dotfiles/development/shell.nix";

      nxgc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
    };
  };
}

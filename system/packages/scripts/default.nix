{pkgs, ...}:
#Make bash scripts and use as pkgs
#If the command is too long you can just execute a bash script from the "text" section
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "eduroam" (builtins.readFile ./eduroam.sh))
    (writeShellScriptBin "inspect" (builtins.readFile ./inspect.sh))

    (writeShellApplication {
      #Git add, commit and push with a message
      name = "gitdo";
      runtimeInputs = with pkgs; [git];

      # Allows reading from a file instead of an inline string
      text = builtins.readFile ./gitdo.sh;
    })

    # Script takes a list from the nix store and returns which ones are duplicated
    # For example the alias "nxls" in the fish config
    # There is a writeHaskell function but I cant get it to work
    (writeShellApplication {
      name = "duplicate";
      runtimeInputs = [pkgs.ghc];
      text = "runghc ${./duplicate.hs}";
    })

    # Uses ripgrep and fzf to jump to where a nixos option is declared
    # Only searches through nix files
    (writeShellApplication {
      name = "e";
      runtimeInputs = with pkgs; [
        fzf
        ripgrep
        #nvim # uncommenting this will use default nvim not nvf
      ];
      text = builtins.readFile ./edit.sh;
    })

    # Bind this to a key, for example in niri.kdl
    /*
    (writeShellApplication {
      name = "z";
      runtimeInputs = with pkgs; [
        fzf
        zathura
      ];

      # Could change -i for smart case
      text = ''zathura "$(fzf -i -e)" &'';
    })
    */

    /*
    (writeShellApplication {
        name = "ty";
        runtimeInputs = with pkgs; [
            zathura
            typst
            foot
            neovim
        ];
        text = builtins.readFile ./ty.sh;
    })
    */
  ];
}

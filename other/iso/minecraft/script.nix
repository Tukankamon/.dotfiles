{
  pkgs,
  ...
}:
#Make bash scripts and use as pkgs
#If the command is too long you can just execute a bash script from the "text" section

{
  environment.systemPackages = with pkgs; [

  (writeShellApplication {
      name = "nxs";
      text = ''
        sudo nixos-rebuild switch --flake ~/.dotfiles/other/iso/minecraft
      '';
    })

    (writeShellApplication {
      name = "test-script";

      runtimeInputs = with pkgs; [
        cowsay
        #lolcat     #Used to make it colorfull
      ]; # Specify pkgs in the script

      text = ''
        cowsay --random --rainbow "this is a test"
      '';
    })

    (writeShellApplication {    #Git add, commit and push with a message
      name = "gitdo";

      runtimeInputs = with pkgs; [ git ];

      text = ''
        Help()
        {
          # Display Help
          echo "Add commit message later in the script"
          echo
          echo "-h for help"
        }

        while getopts ":h" option; do
          case $option in
              h) # display Help
                Help
                exit;;
              \?) # Invalid option
                echo "Error: Invalid option"
                exit;;

          esac
        done

        echo "Commit description: "
        read -r message

        git add -A && \
        git commit -m "$message" && \
        git push origin main
      '';
    })
  ];
}

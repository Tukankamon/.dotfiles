{pkgs, ...}:
#Make bash scripts and use as pkgs
#If the command is too long you can just execute a bash script from the "text" section
{
    environment.systemPackages = with pkgs; [

        (writeShellApplication {
            #Git add, commit and push with a message
            name = "gitdo";

            runtimeInputs = with pkgs; [git];

            # Allows reading from a file instead of an inline string
            text = builtins.readFile ./scripts/gitdo.sh;
        })

        (writeShellApplication {
            name = "ty";

            runtimeInputs = with pkgs; [
                zathura
                typst
                foot
                neovim
            ];

            text = builtins.readFile ./scripts/ty.sh;
        })
    ];
}

{
  pkgs,
  ...
}:
#Make bash scripts and use as pkgs
#If the command is too long you can just execute a bash script from the "text" section

{
  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "test-script";

      runtimeInputs = with pkgs; [
        cowsay
        #lolcat     #Used to make it colorfull
      ]; # Specify pkgs in the script

      text = ''
        cowsay "this is a test" --rainbow --random
      '';
    })
  ];
}

{
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;

    #look for wryan kitty theme or Base2Tone
    extraConfig = builtins.readFile ./kitty.conf;

  };
  # The colors are being managed by stylix1
}

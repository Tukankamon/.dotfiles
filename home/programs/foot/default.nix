{...}: {
  programs.foot = {
    enable = true;
  };

  # I dont like this workaround. Should probably wrap it
  /*
  home.file.".config/foot/foot.ini" = {
    source = ./foot.ini;
  };
  */
}

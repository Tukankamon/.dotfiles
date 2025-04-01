{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    #confirm_os_window_close = 0;

    /*
      font = {
        name = "JetBrainsMono Nerd Font";
      };
    */

    #look for wryan kitty theme or Base2Tone
    extraConfig = ''

      map ctrl+plus      increase_font_size
      map ctrl+minus    decrease_font_size
      map ctrl+0 restore_font_size

      font_family FiraCode Nerd Font Mono

      foreground #f8f8f2
      background #1f262d
      url_color #0087bd
      url_style curly

      background_opacity 0.8
      background_blur 1

      color0       #00384d
      color8       #517f8d
      #: black

      color1       #c43061
      color9       #ff5a67
      #: red

      color2       #7fc06e
      color10      #9cf087
      #: green

      color3       #f08e48
      color11      #ffcc1b
      #: yellow

      color4       #1c8db2
      color12      #7eb2dd
      #: blue

      color5       #c694ff
      color13      #fb94ff
      #: magenta

      color6       #00cccc
      color14      #00ffff
      #: cyan

      color7       #77929e
      color15      #b7cff9
      #: white
    '';

  };

}

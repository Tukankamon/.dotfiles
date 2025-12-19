{
    ...
}: {
  # Mainly for keyboard config
  imports = [];

  services.xserver = {
    enable = true; # Even if on wayland

    xkb = {
      layout = "es";
      variant = "AltGreek";

      extraLayouts.AltGreek = {
        description = "Normal keyboard just changing the Alt Gr behaviour";
        languages = ["spa"];

        symbolsFile = ./AltGreek;
      };
    };

    #videoDrivers = ["amdgpu"]

    autoRepeatDelay = 0;
    autoRepeatInterval = 50;
  };

  # On the console
  console.keyMap = "es";
}
/*
services.xserver.wacom.enable = true;  #Wacom tablet
hardware.opentabletdriver.enable = true;
*/


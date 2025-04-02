{
  pkgs,
  ...
}:
#Exposed from the flake for custom scripts

{
  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "cv-turn-in";

      text = ''
      echo "Entregando al campus virtual"
      xdg-open https://campusvirtual.cv.uma.es/
      sleep 3
      xdotool key q

    '';
    })
  ];
}

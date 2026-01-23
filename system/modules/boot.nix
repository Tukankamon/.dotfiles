{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.boot.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "sets the boot config for the pc";
  };

  config = lib.mkIf config.modules.boot.enable {
    boot = {
      loader = {
        systemd-boot.enable = false; # Change when using / not using grub

        efi.canTouchEfiVariables = true;

        timeout = 1;
        grub = {
          enable = true;
          devices = ["nodev"];
          efiSupport = true;
          useOSProber = true; #Detects other operating systems, doesnt detect windows on other drive
          #splashImage = ./../../other/images/matrix-options.png;
          theme = pkgs.stdenv.mkDerivation {
            pname = "bsol";
            version = "1.0";
            src = pkgs.fetchFromGitHub {
              # Windows blue screen theme, default font is ugly af. Too cumbersome to change
              owner = "harishnkr";
              repo = "bsol";
              rev = "afcc66069d104e4c02bc962e6bebd9c453c0f163";
              hash = "sha256-cj8yfdnR0n814piUZowUKEB2n9CWlsC97DScqxn7Cto=";
            };
            installPhase = "cp -r bsol \$out";
          };
          extraEntries = ''
            menuentry "Reboot" {
                reboot
            }
          '';
        };
      };

      kernelModules = [
        "snd-seq" # Forgot what this is for, seems like an ALSA driver
        "snd-rawmidi"
      ];
      kernelParams = ["kvm.enable_virt_at_load=0"]; # For virtualbox

      plymouth = {
        enable = false;
        theme = "spinfinity";
      };
    };

    security.polkit.enable = true; # I think this is also needed
  };
}

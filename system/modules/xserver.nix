{}: {
  # Mainly for keyboard config
  imports = [];

  services.xserver = {
    enable = true; # Even if on wayland

    xkb = {
      layout = "es";

      extraLayouts.AltGreek = {
        description = "Normal keyboard just changing the Alt Gr behaviour";
        languages = ["spa"];

        symbolsFile = ''
                  partial alphanumeric_keys
                  xkb_symbols "greek" {
                      include "es(basic)"

                        key <AD01> { [ q, Q, theta, Theta ] };
                        key <AD03> { [ e, E, epsilon, Epsilon ] };
                        key <AD04> { [ r, R, rho, Rho ] };
                        key <AD05> { [ t, T, tau, Tau ] };
                        key <AD06> { [ y, Y, psi, Psi ] };
                        key <AD08> { [ i, I, iota, Iota ] };
                        key <AD09> { [ o, O, omega, Omega ] };
                        key <AD10> { [ p, P, pi, Pi ] };

                        key <AC01> { [ a, A, alpha, Alpha ] };
                        key <AC02> { [ s, S, sigma, Sigma ] };
                        key <AC03> { [ d, D, delta, Delta ] };
                        key <AC04> { [ f, F, phi, Phi ] };
                        key <AC05> { [ g, G, gamma, Gamma ] };
                        key <AC06> { [ h, H, eta, Eta ] };
                        key <AC08> { [ k, K, kappa, Kappa ] };
                        key <AC09> { [ l, L, lambda, Lambda ] };

                        key <AB01> { [ z, Z, zeta, Zeta ] };
                        key <AB02> { [ x, X, xi, Xi ] };
                        key <AB03> { [ c, C, chi, Chi ] };
                        key <AB05> { [ b, B, beta, Beta ] };
                        key <AB06> { [ n, N, nu, Nu ] };
                        key <AB07> { [ m, M, mu, Mu ] };
                  }
        '';
      };
    };

    #videoDrivers = ["amdgpu"]

    autorepeatDelay = 0;
    autoRepeatInterval = 50;
  };

  # On the console
  console.keymap = "es";
}
/*
services.xserver.wacom.enable = true;  #Wacom tablet
hardware.opentabletdriver.enable = true;
*/


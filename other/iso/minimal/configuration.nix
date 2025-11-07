{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    "${modulesPath}/instsaller/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # ISO image settings (from minimal installer)
  isoImage.edition = "custom";

  users.users.nixos = {
    isNormalUser = true;
    password = "nixos";
    extraGroups = ["wheel" "networkmanager"];
  };

  # Add your desired packages here
  environment.systemPackages = with pkgs; [
    git
    vim
    ripgrep
    curl
    wget
    htop
    tmux
    man-pages
    man-db
    tree
    parted
    testdisk
    fish
  ];

  # Enable SSH for remote login (optional)
  services.openssh.enable = true;

  # This is needed for ISO booting
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;

  # Optional: use Zsh or fish as default shell
  # users.defaultUserShell = pkgs.zsh;

  environment.shellInit = ''
    echo "Let's get this done"
    echo "Hostname: $(hostname)"
    echo "Nix version: $(nix --version)"
  '';
}

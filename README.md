# My nixos dotfiles

It includes a laptop and a pc configuration. Only difference is laptop doesn't have steam, discord etc.

Currently niri is enabled but can be changed for gnome or hyprland (not customized)

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/26d032db-2653-4ab4-b597-da14f3330cd1" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/fd6e3775-8df6-4112-8590-1f0c20832c4c" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/142b4461-6dfb-45d3-bdfb-dbda14f617f8" />


# Instalation

Run 
```bash
sudo nixos-rebuild switch --flake github:Tukankamon/.dotfiles#yamask
```

"yamask" is the pc host while "dwebble" is the laptop one

If you have cloned the repo locally you can change the flake path to the local one

You must set the user password with the passwd command. There is an explanation for this in pc/configuration.nix or laptop/configuration.nix in the user configuration

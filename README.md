# My nixos dotfiles

It includes a laptop and a pc configuration. Only difference is laptop doesn't have steam, discord etc.

Currently niri is enabled but can be changed for gnome or hyprland (not customized)

The pc host specifically comes with a specialisation for gnome, meaning for every rebuild you will get an extra one but instead of niri it will have gnome enabled

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/26d032db-2653-4ab4-b597-da14f3330cd1" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/fd6e3775-8df6-4112-8590-1f0c20832c4c" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/142b4461-6dfb-45d3-bdfb-dbda14f617f8" />


# Setup

Run 
```bash
bash <(curl -S https://raw.githubusercontent.com/Tukankamon/.dotfiles/main/setup.sh) <HOSTNAME> <RepoName> (Optional)
```

Set the HOSTNAME parameter to either yamask or dwebble.
"yamask" is the pc host while "dwebble" is the laptop one

RepoName is optional is the name of your cloned repo
It is used when running: git clone https://github.com/Tukankamon/.dotfiles.git RepoName

If you have cloned the repo locally you can do the following only after having copied /etc/nixos/hardware-configuration.nix into either .dotfiles/pc or .dotfiles/laptop

Failure to do so will most likely crash your system
```bash
sudo nixos-rebuild switch --flake .#<HOSTNAME>
```

You must set the user password with the passwd command
There is an explanation for this in pc/configuration.nix or laptop/configuration.nix in the user configuration

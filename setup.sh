#!/bin/bash

# Bash script that sets up the nixos configuration
# It does this by cloning the repo from github and then copying /etc/nixos/hardwareconfiguration.nix into whichever host is specified
# It then asks if you want to rebuild

HOST="$1"

if [ -z "$HOST" ]; then
	echo "Usage: bash setup.sh <HOSTNAME> <RepoName> (Optional)"
fi

if [ "$HOST" != "dwebble" ] && [ "$HOST" != "yamask" ]; then
	echo "There was an incorrect hostname (or none at all), defaulting to yamask"
	HOST="yamask"
fi

REPO="$2"

if [ -z "$REPO" ]; then
	REPO=".dotfiles"
fi

git clone https://github.com/Tukankamon/.dotfiles.git "$REPO" || {
	echo "git clone failed"
	exit 1
}

case "$HOST" in
"yamask") SYS="pc" ;;
"dwebble") SYS="laptop" ;;
*) SYS="pc" ;;
esac

cp /etc/nixos/hardware-configuration.nix ./"$REPO"/"$SYS"/hardware-configuration.nix || {
	echo "could not copy from /etc/nixos"
	exit 1
}

read -rp "All done would you like to rebuild the system? [y/N]: " answer

# This just accepts any lowercase-uppercase combo of "y" or "yes"
if [[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]]; then
	cd "$REPO"
	sudo nixos-rebuild switch --flake .#"$HOST"
else
	echo "Rebuild skipped"
fi

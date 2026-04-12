#!/usr/bin/env bash
# Inspect a custom or not nixos option

if [ $# -ne 1 ]; then
	echo "Usage: $0 <option>"
	exit 1
fi

if [ $1 == "help" ]; then
	echo "Usage: $0 <option>"
	echo "Inspect a nixos option of the type nixosConfiguration.$(hostname).options.myOpt by running the following command: $0 myOpt"
	echo "This will return a json list of all subOptions contained in myOpt"
	echo "For example, running: $0 modules, will inspect the "modules" option which contains all the other custom options defined in this system"
	echo "Some common options might be "modules" (for all the custom options), "services", "programs", etc"

	echo "\nRun: $0 repl to get a nix repl to check the current values of options by for example running: config.modules.boot.enable (inside the repl) which will print out whatever its current option is"
	echo "Run: $0 help, to show this page"
	exit 0
fi

if [ $1 == "repl" ]; then
	sudo nixos-rebuild repl --flake ~/.dotfiles\#$(hostname)
	exit 0
fi

DIR="$HOME/.dotfiles"

# can only check for options visible to current system
nix eval "$DIR#nixosConfigurations.$(hostname).options.$1" --json || echo "Option <nixosConfigurations.$(hostname).options.$1> not found in the flake in $DIR"

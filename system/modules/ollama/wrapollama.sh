#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Provide a directory to cat out"
	exit 1
fi

DIR="$1"
find "$DIR"/ -type f -name '*.nix' | xargs tail -n +1 

#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Provide a directory to cat out"
	exit 1
fi

DIR="$1"

for f in "$DIR"/*.nix; do
	echo "$PWD"
	echo "This is file $f"
	cat "$f"
	echo -e "\n=================\n"
done

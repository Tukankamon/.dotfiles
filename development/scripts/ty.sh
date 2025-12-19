#!/usr/bin/env bash


if [ -z "$1" ]; then
    echo "Usage: $0 file (no typ extension)"
fi

FILE="${1}.typ"

# Escape char so it works on nix
PDF="${FILE}.pdf"

foot -- "typst watch '$FILE'; exec bash" &
nvim "$FILE" &
zathura "$PDF"

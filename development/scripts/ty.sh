#!/usr/bin/env bash
# BROKEN
# Works normally by chmod but doesnt trhough nix


if [ -z "$1" ]; then
    echo "Usage: $0 file.typ"
fi

# Maybe needs core utils
FILE="$(realpath "$1")"

# Escape char so it works on nix
PDF="${FILE%.typ}.pdf"

foot -- "typst watch '$FILE'; exec bash" &
nvim "$FILE" &
zathura "$PDF"

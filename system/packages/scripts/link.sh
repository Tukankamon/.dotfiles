#!/usr/bin/env bash

# This script links movies from the qBittorrent downlaods to the jellyfin media library
# It also checks to only give you ones that arent already linked
# Only useful on the server

# One uses find for the printf command, fd is faster
# Sed to normalize the names and remove the '/' at the end
# comm -23 returns the ones in downloads/ not in media/
valid=$(comm -23\
  <(fd -d 1 . '/var/lib/qBittorrent/qBittorrent/downloads' | sed 's:/$::' | sort)\
  <(find /home/aved/media -type l -printf '%l\n' | sed 's:/$::' | sort))

if [[ -z $valid ]]; then
  echo "All files are already linked"
  exit 0
fi

file=$(echo "$valid" | fzf -i)
[[ -z "$file" ]] && exit 1
echo "Origin: $file"

# \n doesnt seem to work as delimiter
mode=$(echo "movies
  shows
  anime" | fzf -i)
[[ -z "$mode" ]] && exit 1
echo "Mode selected: $mode"

echo ""
echo "Input the target: "
read -r destName
destination="$HOME/media/$mode/$destName"
echo "Destination: $destination"
echo ""
echo "Type 'Y' (capital) to confirm"
read -r conf
[[ "$conf" == 'Y' ]] && ln -s "$file" "$destination"

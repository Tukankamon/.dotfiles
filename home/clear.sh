#!/usr/bin/env bash

# clears the .config directory so dotter doesnt have any conflicts

set -e
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"

for dotter_dir in "$script_dir"/*/; do
  [[ -d "$dotter_dir" ]] || continue
  target="$config_dir/$(basename "$dotter_dir")"

  if [[ -L "$target" ]]; then
    echo "removing symlink: $target"
    rm "$target"
  elif [[ -d "$target" ]]; then
    echo "removing directory: $target"
    rm -rf "$target"
  fi
done

echo "done."

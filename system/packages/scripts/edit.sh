#!/usr/bin/env bash
# This script was vibecoded

[[ $# -lt 1 ]] && echo "Usage: $0 <search term> <directory>" && exit 1

term="$1"
dir="${2:-$HOME/.dotfiles}"

# Sed removes the ~/.dotfiles from every direcrory and normalizes to avoid clutter
match=$(rg -in "$term" "$dir" -t nix | \
    sed "s|^$dir/||" | \
    awk -F: '!seen[$1]++ { 
        file=$1; 
        line=$2+0;              # force numeric
        rest=substr($0,length($1)+length($2)+3);  # everything after filename:line:
        print file "\t" line "\t" rest
    }')



count=$(echo "$match" | grep -c '^' || echo 0)

if [ "$count" -eq 1 ]; then
  file=$(echo "$match" | cut -f1)
  line=$(echo "$match" | cut -f2)
  nvim +"$line" "$dir/$file"
else
  # Multiple matches, choose with fzf
  match=$(echo "$match" | \
    fzf --ansi \
    --preview "bat --style=numbers --color=always --highlight-line {2} $dir/{1}" \
    --preview-window=right:60%)

  [[ -z "$match" ]] && exit 0
  file=$(echo "$match" | cut -f1)
  line=$(echo "$match" | cut -f2)
  nvim +"$line" "$dir/$file"
fi

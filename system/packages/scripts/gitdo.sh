#!/usr/bin/env bash

Help()
{
  # Display Help
  echo "Runs git add, commit and push and prompts you for a git message"
  echo
    echo "-m to add a commit message inline (use quotes for multiword inputs)"
  echo "-p to pull before pushing"
  echo "-r to change the remote (default is main)"
  echo "-h for help"
}

MAIN="main"

while getopts ":hpr:m:" option; do
  case $option in
      h)
        Help
        exit;;

      p)
        PULL=1;;

      r)
        MAIN="$OPTARG";;

      m)
        MSG="$OPTARG";;

      \?) 
        echo "Error: Invalid option -$OPTARG"
        exit 1;;

  esac
done

if [[ -z "$MSG" ]]; then
  echo "Commit description: "
  read -r MSG
fi


git add -A
git commit -m "$MSG" 

if [[ -n "$PULL" ]]; then
  git pull origin "$MAIN" && git push origin "$MAIN";

else git push origin "$MAIN"
fi

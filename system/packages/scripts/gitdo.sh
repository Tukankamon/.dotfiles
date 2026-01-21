#!/usr/bin/env bash

Help()
{
  # Display Help
  echo "Add commit message later in the script"
  echo
  echo "-h for help"
}

while getopts ":h" option; do
  case $option in
      h) # display Help
        Help
        exit;;
      \?) # Invalid option
        echo "Error: Invalid option"
        exit;;

  esac
done

if [[ -z "$1" ]]; then
  echo "Commit description: "
  read -r message;

else message="$1";

fi


git add -A && \
git commit -m "$message" && \
git push origin main

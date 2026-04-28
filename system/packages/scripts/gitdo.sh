#!/usr/bin/env bash

Help() {
	# Display Help
	echo "Runs the alejandra formatter, git add, commit, <push> and prompts you for a git message"
	echo
	echo "-m to add a commit message inline (use quotes for multiword inputs)"
	echo "-p to pull before pushing"
	echo "-r to change the remote (default is main)"
  echo "-o to push after the commit"
	echo "-h for help"
}

MAIN="main"
PULL=0
PUSH=0
MSG=""

while getopts ":hpro:m:" option; do
	case $option in
	h)
		Help
		exit
		;;

	p)
		PULL=1
		;;

	r)
		MAIN="$OPTARG"
		;;

	m)
		MSG="$OPTARG"
		;;
  o)
    PUSH=1
    ;;

	\?)
		echo "Error: Invalid option -$OPTARG"
		exit 1
		;;

	esac
done

if [[ -z "$MSG" ]]; then
	echo "Commit description: "
	read -r MSG
fi

alejandra ~/.dotfiles # This could be different on ther systems
git add -A
git commit -m "$MSG"

if [[ $PULL == 1 ]]; then
	git pull origin "$MAIN"
fi

if [[ $PUSH == 1 ]]; then
	git pull origin "$MAIN"
fi

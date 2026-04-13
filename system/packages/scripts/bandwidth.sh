#!/usr/bin/env bash
# From luke smith:
# https://www.youtube.com/watch?v=cvDyQUpaFf4
# Measure bandwitdh used in a time interval

init="$(($(cat /sys/class/net/[ew]*/statistics/rx_bytes | paste -sd '+')))"
printf "Recording bandwidth. Press enter to stop."
read -r foo
fin="$(($(cat /sys/class/net/[ew]*/statistics/rx_bytes | paste -sd '+')))"
printf "%4sB of bandwidth used.\\n" $(numfmt --to=iec $(($fin-$init)))

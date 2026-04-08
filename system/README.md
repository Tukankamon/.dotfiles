# ./modules vs ./packages

The packages folder contains either custom packages like ./packages/cursor.nix or simply installs a list of related packages like for example programming.nix that installs some basic programming related packages

Modules on the other hand are toggleable pieces of code. This doesn't mean they can't simply install packages as is the case with ./modules/ardour.nix which simply installs ardour and some plugins but it is in the modules folder since it is a toggleable feature


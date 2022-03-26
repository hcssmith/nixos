# nixos
My Flake based nixos configuration

# usage
In order to build a new system create a hosts.<sysname>.module entry and import the relevant modules

# layout

## config
For Non nix based config e.g. imported config files (Not in package ovrerides)

## home
Home manager config for users

## hosts
Minimum hosts definition (boot details / networking / system sate / hardware-configuration)
base.nix contains the standard config for all hosts (locale, keymaps, time, etc.)

## modules
Nix configs that can be shared between hosts (eg gnome setup)

## overlays
Overriden packages, create a folder with a default.nix that calls <package>.override then in overlays/default.nix add a call package line 

## users
Setup for users

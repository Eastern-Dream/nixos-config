# nixos-config
This repository is my NixOS configuration

## First Time Setup
If shell profile is not built, run this in repository root to rebuild:

`sudo nixos-rebuild boot --upgrade -I nixos-config="$(pwd)/configuration.nix"`

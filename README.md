# nixos-config
This repository is my NixOS configuration. It's a mess, but it's my mess.

## First Time Setup
```sh
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --update
sudo nixos-rebuild boot --upgrade -I nixos-config="$(pwd)/configuration.nix"
```

Then, check host option to make sure you are using the right host

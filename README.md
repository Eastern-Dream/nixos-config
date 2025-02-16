# nixos-config
This repository is my NixOS configuration. It's a mess, but it's my mess.

## First Time Setup
Clone to `/home/your-username/.dotfile/`, then run the below:
```sh
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable
sudo nixos-rebuild boot --upgrade -I nixos-config="$(pwd)/configuration.nix"
```

Then, check host option to make sure you are using the right host.

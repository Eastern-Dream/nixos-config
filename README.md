# nixos-config
This repository is my NixOS configuration. It's a mess, but it's my mess.

## First Time Bootstrap
Clone to wherever, then enter a shell with git `nix-shell -p git`:

```sh
git clone https://github.com/Eastern-Dream/nixos-config
sudo rm -r /etc/nixos
sudo ln -s $(pwd)/nixos-config /etc/nixos
sudo nixos-generate-config
```
Go to github on the browser, login, and generate a new PAT token (contents read-only) for my private ssh repository.
```sh
git submodule init
git submodule update
```
Enter username and PAT token for password to clone the ssh-config repo.
VERY IMPORTANT - Check host option to make sure you are using the right host.
```sh
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable
sudo nixos-rebuild boot --upgrade
```

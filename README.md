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
Go to github on the browser, login, and generate a new PAT token (contents read-only) for my private ssh repository. Enter username and PAT token for password to clone the ssh-config repo.
```sh
git submodule init
git submodule update
```
Then, symlink the ssh directory:
```sh
rm -r ~/.ssh
ln -s $(pwd)/nixos-config/artifact/ssh-config ~/.ssh
```

VERY IMPORTANT - Check host option to make sure you are using the right host.
```sh
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable
sudo nixos-rebuild boot --upgrade
```

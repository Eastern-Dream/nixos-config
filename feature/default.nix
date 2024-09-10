{ config, pkgs, ... }:

{
    imports = [
        ./virtualisation/default.nix

        ./gaming.nix

        ./music.nix

        ./printing.nix

        ./vpn.nix

        ./bluetooth.nix
    ];
}

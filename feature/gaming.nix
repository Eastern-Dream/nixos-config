{ config, pkgs, ... }:

{
    # udev rules for tablets and controllers
    hardware.steam-hardware.enable = true;
    hardware.opentabletdriver.enable = true;

    users.users.${config.identity.username}.packages = with pkgs; [
        lutris
        prismlauncher
    ];
}

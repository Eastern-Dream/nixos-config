{ config, pkgs, ... }:

{
    # udev rules for tablets and controllers
    hardware.opentabletdriver.enable = true;

    # native steam stuff 
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
    };

    # If native steam is used, then dont need these 2
    hardware.opengl.driSupport32Bit = true;
    hardware.steam-hardware.enable = true;

    users.users.${config.identity.username}.packages = with pkgs; [
        lutris
        prismlauncher
    ];
}

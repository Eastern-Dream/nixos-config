{ config, pkgs, ... }:

{
    # Music related packages
    users.users.${config.identity.username}.packages = with pkgs; [
        # System-wide EQ
        easyeffects

        # Player
        deadbeef
        tauon

        # Dependencies
        opusTools
        lame

        # Tagger
        picard
    ];

    # tmpfile rules for deadbeef plugins
    systemd.tmpfiles.rules = [ 
        "L+ /home/${config.identity.username}/.local/lib/deadbeef/discord_presence.so - - - - /home/${config.identity.username}/.dotfile/nixos-config/artifact/discord_presence.so" 
        "L+ /home/${config.identity.username}/.local/lib/deadbeef/mpris.so - - - - /home/${config.identity.username}/.dotfile/nixos-config/artifact/mpris.so" 
    ];

}

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

    home-manager.users.${config.identity.username} = {
    # Deadbeef plugins
        home.file.".local/lib/deadbeef/discord_presence.so".source = ../artifact/discord_presence.so;
        home.file.".local/lib/deadbeef/mpris.so".source = ../artifact/mpris.so;
    };
}

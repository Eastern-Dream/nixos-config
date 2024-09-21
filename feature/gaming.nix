{ config, pkgs, ... }:

{
    # Gamescope nested workaround (https://github.com/NixOS/nixpkgs/issues/162562#issuecomment-1229444338)
    nixpkgs.config.packageOverrides = pkgs: {
        steam = pkgs.steam.override {
            extraPkgs = pkgs: with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
            ];
        };
    };
    
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
    # hardware.opengl.driSupport32Bit = true;
    # hardware.steam-hardware.enable = true;

    users.users.${config.identity.username}.packages = with pkgs; [
        lutris
        prismlauncher
    ];

    # workaround for steam download speed issues on linux (https://github.com/ValveSoftware/steam-for-linux/issues/10248)
    home-manager.users.${config.identity.username} = {
        home.file.".var/app/com.valvesoftware.Steam/.local/share/Steam/steam_dev.cfg".text = ''
            @nClientDownloadEnableHTTP2PlatformLinux 0
            @fDownloadRateImprovementToAddAnotherConnection 1.1
            @cMaxInitialDownloadSources 15
            unShaderBackgroundProcessingThreads 8
        '';
    };
}

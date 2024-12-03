{ config, pkgs, ... }:

{
    # Gamescope nested session workaround (https://github.com/NixOS/nixpkgs/issues/162562#issuecomment-1229444338)
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
                # Fix CJK font
                noto-fonts-cjk-sans
            ];
        };
    };
    
    # programs.corectrl = {
    #     enable = true;
    #     gpuOverclock.enable = true;
    # };
    
    # udev rules for tablets and controllers
    hardware.opentabletdriver.enable = true;
    # Enable xbox controller
    hardware.xpadneo.enable = true;

    hardware.bluetooth.settings = {
    General = {
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = true;
    };
    };
    
    # native steam stuff 
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
    };

    users.users.${config.identity.username}.packages = with pkgs; [
        lutris
        prismlauncher
    ];

    # workaround for steam download speed issues on linux (https://github.com/ValveSoftware/steam-for-linux/issues/10248)
    # home-manager.users.${config.identity.username} = {
    #     home.file.".var/app/com.valvesoftware.Steam/.local/share/Steam/steam_dev.cfg".text = ''
    #         @nClientDownloadEnableHTTP2PlatformLinux 0
    #         @fDownloadRateImprovementToAddAnotherConnection 1.1
    #         @cMaxInitialDownloadSources 15
    #         unShaderBackgroundProcessingThreads 8
    #     '';
    # };
}

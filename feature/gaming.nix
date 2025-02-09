{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
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
    
    # udev rules for tablets and controllers
    hardware.opentabletdriver.enable = true;
    # Enable xbox controller (if not working must first be paired on a windows machine)
    hardware.xpadneo.enable = true;
    hardware.xone.enable = true;
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
        localNetworkGameTransfers.openFirewall = true;
        # gamescopeSession = {
        #     enable = true;
        #     args = [ "-e" "--hdr-enabled" "--xwayland-count 2" ];
        # };
    };

    environment.interactiveShellInit = ''
        alias my-gamescope='\
        STEAM_MULTIPLE_XWAYLANDS=1 \
        gamescope -e -W 3840 -H 2160 -r 120 --adaptive-sync --xwayland-count 2 \
        --hdr-enabled --hdr-itm-enable --hdr-itm-sdr-nits 300 --hdr-debug-force-output -- steam -gamepadui -steamos3 -steampal -steamdeck -pipewire-dmabuf'
    '';
        # WINEDLLOVERRIDES=dxgi=n \
        # STEAM_GAMESCOPE_COLOR_TOYS=1 \
        # GAMESCOPE_VRR_ENABLED=1 \
        # STEAM_GAMESCOPE_HDR_SUPPORTED=1 \
        # STEAM_GAMESCOPE_VRR_SUPPORTED=1 \
        # DXVK_HDR=1 \
        # ENABLE_GAMESCOPE_WSI=1 \
        # STEAM_GAMESCOPE_COLOR_MANAGED=1 \
    users.users.${config.identity.username}.packages = with pkgs; [
        unstable.lutris
        prismlauncher
    ];

}

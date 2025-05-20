{ config, pkgs, lib, ... }:

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
                mangohud
                # Fix CJK font
                noto-fonts-cjk-sans
            ];
        };
    };

    # native steam stuff 
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        extraCompatPackages = [ unstable.proton-ge-bin pkgs.steamtinkerlaunch ];
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

    # Fix dualshock5 controller
    # hardware.bluetooth.input = {
    #     General = {
    #         UserspaceHID = true;
    #     };
    # };


    # Gamescope stuff
    programs.gamescope = {
        enable = true;
       # capSysNice = true;
    };
    # gamescope tty args
    environment.interactiveShellInit = ''
        alias my-gamescope='\
        STEAM_MULTIPLE_XWAYLANDS=1 \
        gamescope -e -W 3840 -H 2160 -r 120 --adaptive-sync --xwayland-count 2 \
        --hdr-enabled -- \
        steam -gamepadui -steamos3 -steampal -steamdeck -pipewire-dmabuf'
    '';

    users.users.${config.identity.username}.packages = with pkgs; [
        unstable.lutris
        prismlauncher
        # Attempting fix dualshock4 controller
        # python312Packages.ds4drv
        # steamtinkerlaunch
    ];

}

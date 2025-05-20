{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  users.users.${config.identity.username}.packages = with pkgs; [
    # Productivity
    firefox
    vscode
    wireshark
    unstable.binaryninja-free
    unstable.ghidra
    
    # Communication
    thunderbird
    vesktop
    discord
    slack

    # Multimedia
    audacity
    obs-studio
    libreoffice-qt6-still
    gimp
    vlc
    unstable.mpv
  ];

  environment.systemPackages = with pkgs; [
    # Essential tools
    wget
    git
    git-lfs
    gparted
    appimage-run
    coreutils
    nix-index
    busybox
    file
    xorg.xwininfo
    binutils

    # ISO/image related tools
    fuseiso
    iat
    libisoburn
    cdrtools
    
    # Components
    nixd
    unstable.cloudflared

    # Archival tools, adds a bunch for Ark optional deps so it can extract most formats
    p7zip
    unar
    unrar
    lzop
    lzip
    pigz

    # System information
    fastfetch
    lm_sensors
    powertop
    htop
    compsize
    btop
    dmidecode
    pciutils
    cpufrequtils
    sysfsutils
    libva-utils
    amdgpu_top
  ];
}
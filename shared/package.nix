{ config, pkgs, ... }:

{
  users.users.${config.identity.username}.packages = with pkgs; [
    # Productivity
    firefox
    vscode
    wireshark

    # Reverse engineer crap
    # gdb
    # pwndbg
    # gdbgui
    # ghidra
    
    # Communication
    thunderbird
    vesktop
    discord
    slack
    
    # Miscellaneous
    # rclone

    # Multimedia
    audacity
    obs-studio
    libreoffice-qt6-still
    gimp
    vlc
    mpv
  ];

  environment.systemPackages = with pkgs; [
    # Essential tools
    wget
    git
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

    # Archival tools, adds a bunch for Ark optional deps so it can extract most formats
    p7zip
    unar
    unrar
    lzop
    lzip

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
{ config, pkgs, ... }:

{
  users.users.${config.identity.username}.packages = with pkgs; [
    # Productivity
    firefox
    vscode
    wireshark
    
    # Communication
    thunderbird
    vesktop
    discord
    
    # Miscellaneous
    
    rclone

    # Multimedia
    obs-studio
    libreoffice-qt
    gimp
    vlc
  ];

  environment.systemPackages = with pkgs; [
    # Essential tools
    wget
    git
    gparted
    appimage-run
    coreutils
    cdrtools
    nix-index
    libisoburn
    busybox
    file
    libva-utils
    nixd
    wl-clipboard

    # Archival tools, adds a bunch for Ark optional deps so it can extract most formats
    p7zip
    unar
    unrar
    lzop
    lzip


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
  ]; 
}
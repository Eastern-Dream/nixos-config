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
    unar
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
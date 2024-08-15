# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # Main import to turn shit off and on by just commenting it out
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      # Permanent shared config
      ./shared.nix

      # Identity
      ./identity.nix

      # Add gaming
      ./gaming.nix

      # Add music
      ./music.nix

      # Add virtualization
      ./virtualization.nix

      # Add printing capability
      ./printing.nix

      # Add VPN and torrenting
      ./vpn.nix
    ];

  # Zen kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fix a rare crash with my SSD model
  boot.kernelParams = lib.mkIf (config.identity.hostname == "workstation") [
    "nvme_core.default_ps_max_latency_us=0"
  ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "${config.identity.hostname}";

  # Desktop Environment crap
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager= {
    sddm.enable = true;
    defaultSession = "plasma";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.identity.username} = {
    isNormalUser = true;
    description = "${config.identity.username}";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

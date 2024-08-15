# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # Main import to turn shit off and on by just commenting it out
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      # Home manager
      <home-manager/nixos>

      # Permanent shared config
      ./shared/default.nix

      # Feature module
      ./feature/default.nix
      
      # System identity
      ./identity.nix
    ];
  config = {
    virtualisation = {
      stack = true;
      vboxKVM = true;
      vfio = true;
      looking-glass = true;
    };

    # Zen kernel
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_lqx;
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

    home-manager.users.${config.identity.username} = {
      /* The home.stateVersion option does not have a default and must be set */
      home.stateVersion = "24.05";

      # Git config
      home.file.".gitconfig".text = ''
        [user]
          email = ${config.identity.gitEmail}
          name = ${config.identity.gitUsername}
        [ssh]
          postBuffer = 524288000
        [url "ssh://git@github.com/"]
          insteadOf = https://github.com/
      '';
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

  };
}

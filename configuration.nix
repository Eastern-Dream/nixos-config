# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # Main import
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      # Home manager
      # <home-manager/nixos>

      # Permanent shared config
      ./shared/default.nix

      # Feature module
      ./feature/default.nix
      
      # System/host/identity/whatever you wanna call it
      ./host/default.nix

      #       (let
      #   module = fetchTarball {
      #     name = "source";
      #     url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      #     sha256 = "sha256-DN5/166jhiiAW0Uw6nueXaGTueVxhfZISAkoxasmz/g=";
      #   };
      #   lixSrc = fetchTarball {
      #     name = "source";
      #     url = "https://git.lix.systems/lix-project/lix/archive/2.91.1.tar.gz";
      #     sha256 = "sha256-hiGtfzxFkDc9TSYsb96Whg0vnqBVV7CUxyscZNhed0U=";
      #   };
      #   # This is the core of the code you need; it is an exercise to the
      #   # reader to write the sources in a nicer way, or by using npins or
      #   # similar pinning tools.
      #   in import "${module}/module.nix" { lix = lixSrc; }
      # )
    ];
  config = {
    # Zen kernel
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    boot.kernelParams = [ "preempt=full" ];
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "${config.identity.hostname}";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
      "dotnet-runtime-6.0.36"
      "dotnet-sdk-6.0.428"
      "dotnet-sdk-wrapped-6.0.428"
    ];

    # Enable nix store optimization every time we build system config
    nix.settings.auto-optimise-store = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.identity.username} = {
      isNormalUser = true;
      description = "${config.identity.username}";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    # home-manager.users.${config.identity.username} = {
    #   /* The home.stateVersion option does not have a default and must be set */
    #   home.stateVersion = "24.05";

    #   # Git config
    #   home.file.".gitconfig".text = ''
    #     [user]
    #       email = ${config.identity.gitEmail}
    #       name = ${config.identity.gitUsername}
    #     [ssh]
    #       postBuffer = 524288000
    #     [url "ssh://git@github.com/"]
    #       insteadOf = https://github.com/
    #   '';
    # };
    # home-manager.backupFileExtension = "backup";

    # Enable sound with pipewire.
    # sound.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?

  };
}

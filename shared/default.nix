{ config, lib, pkgs, ... }:
# Common shared config that I want on PERMANENTLY for all systems
{
  imports =
    [
      # Add packages
      ./package.nix
      
      # Add localisation properties
      ./localisation.nix

      # Add some shell profile stuff
      ./shell-profile.nix

      # Add nix-ld to run unpatched binary
      ./nix-ld.nix
    ];

  zramSwap.enable = true;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix store optimization every time we build system config
  nix.settings.auto-optimise-store = true;

  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable SSHD
  services.sshd.enable = true;

  # Need this for EasyEffects to work, among other things
  programs.dconf.enable = true;
  
  # Enable Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # Enable high fidelity playback codecs
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  
  # Enable AppImage run wrapper
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.icu ];
    };
  };
}

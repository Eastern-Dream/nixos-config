# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  home-manager.users.${config.identity.username} = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "24.05";

    # GTK IM workaround on Wayland, the last line is added, the rest above it was already there before I started implementation
    home.file.".gtkrc-2.0".text = ''
      gtk-theme-name=""
      gtk-sound-theme-name="ocean"
      gtk-enable-animations=1
      gtk-primary-button-warps-slider=1
      gtk-toolbar-style=3
      gtk-menu-images=1
      gtk-button-images=1
      gtk-cursor-theme-size=24
      gtk-cursor-theme-name="breeze_cursors"
      gtk-icon-theme-name="breeze"
      gtk-font-name="Noto Sans,  10"

      gtk-im-module="fcitx"
    '';

    home.file.".config/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=false
      gtk-button-images=true
      gtk-cursor-theme-name=breeze_cursors
      gtk-cursor-theme-size=24
      gtk-decoration-layout=icon:minimize,maximize,close
      gtk-enable-animations=true
      gtk-font-name=Noto Sans,  10
      gtk-icon-theme-name=breeze
      gtk-menu-images=true
      gtk-modules=colorreload-gtk-module
      gtk-primary-button-warps-slider=true
      gtk-sound-theme-name=ocean
      gtk-toolbar-style=3
      gtk-xft-dpi=98304

      gtk-im-module=fcitx
    '';

    home.file.".config/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=false
      gtk-cursor-theme-name=breeze_cursors
      gtk-cursor-theme-size=24
      gtk-decoration-layout=icon:minimize,maximize,close
      gtk-enable-animations=true
      gtk-font-name=Noto Sans,  10
      gtk-icon-theme-name=breeze
      gtk-modules=colorreload-gtk-module
      gtk-primary-button-warps-slider=true
      gtk-sound-theme-name=ocean
      gtk-xft-dpi=98304

      gtk-im-module=fcitx
    '';

    home.file.".local/lib/deadbeef/discord_presence.so".source = ./artifact/discord_presence.so;
    home.file.".local/lib/deadbeef/mpris.so".source = ./artifact/mpris.so;
  };
}

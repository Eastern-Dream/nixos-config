{ config, pkgs, ... }:

{ 
    
    # Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
    };

    # FCITX5 for japanese and vietnamese input
    i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.waylandFrontend = true;
        fcitx5.addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
            fcitx5-bamboo
        ];
    };

    # Fixes IM on some application, don't use GTK_IM_MODULE="xim" because it breaks wayland apps IM
    environment.variables = {
        # Only for QT 6.7+, which, by the virtue of using KDE plasma 6, I have
        QT_IM_MODULES="wayland;fcitx;ibus";
    };

    # Asian font
    fonts.packages = with pkgs; [
      noto-fonts-cjk
    ];

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    i18n.supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
    ];
    
    home-manager.users.${config.identity.username} = {
    # Steam flatpak IM fix
    home.file.".local/share/flatpak/overrides/com.valvesoftware.Steam".text = ''
      [Environment]
      GTK_IM_MODULE=xim
    '';

    # GTK IM workaround on Wayland, the last line is added, the rest above it was already there before I started implementation
    # home.file.".gtkrc-2.0".text = ''
    #   gtk-theme-name=""
    #   gtk-sound-theme-name="ocean"
    #   gtk-enable-animations=1
    #   gtk-primary-button-warps-slider=1
    #   gtk-toolbar-style=3
    #   gtk-menu-images=1
    #   gtk-button-images=1
    #   gtk-cursor-theme-size=24
    #   gtk-cursor-theme-name="breeze_cursors"
    #   gtk-icon-theme-name="breeze"
    #   gtk-font-name="Noto Sans,  10"

    #   gtk-im-module="fcitx"
    # '';

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
    
  };
}
{ config, pkgs, ... }:

{ 
    
    # Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
    };

    # FCITX5 for japanese and vietnamese input
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
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
      noto-fonts-cjk-sans
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
    
  #   home-manager.users.${config.identity.username} = {
  #   # Steam flatpak IM fix
  #   home.file.".local/share/flatpak/overrides/com.valvesoftware.Steam".text = ''
  #     [Environment]
  #     GTK_IM_MODULE=xim
  #   '';
}
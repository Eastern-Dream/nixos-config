{ config, pkgs, ... }:

{
    # Mullvad VPN firewall
    services.mullvad-vpn.enable = true;

    users.users.${config.identity.username}.packages = with pkgs; [
        qbittorrent-qt5
    ];
}

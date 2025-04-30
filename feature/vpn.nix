{ config, pkgs, ... }:

{
    # Mullvad VPN firewall
    # services.mullvad-vpn.enable = true;
    # current using a friend's vpn

    users.users.${config.identity.username}.packages = with pkgs; [
        qbittorrent
        protonvpn-gui
    ];
}

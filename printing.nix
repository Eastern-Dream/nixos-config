{ config, pkgs, ... }:

{
  # Some options are exclusive to my printer at home
  services.printing.enable = true;
  hardware.sane.enable = true;
  services.printing.drivers = with pkgs; [ canon-cups-ufr2 ];
  users.users.${config.identity.username}.extraGroups = [ "scanner" "lp" ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  environment.interactiveShellInit = ''
    alias printer-scan='scanimage --resolution 300 --format tiff > ~/Documents/printer-scan/$(date -Iseconds).tiff'
  '';
}

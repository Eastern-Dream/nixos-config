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

  environment.systemPackages = with pkgs; [ libtiff_t ];

  environment.interactiveShellInit = ''
    alias scan-start='scanimage --device-name="escl:https://192.168.1.4:443" --resolution 300 --format tiff > tiff2pdf -j > ~/Documents/printer-scan/$(date -Iseconds).pdf'
  '';
}

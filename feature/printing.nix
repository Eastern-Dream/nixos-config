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

  # environment.interactiveShellInit = ''
  #   alias scan-start='export SCANPATH="~/Documents/printer-scan/$(date -Iseconds)" \
  #   & scanimage --device-name="escl:https://192.168.1.4:443" --resolution 300 --format tiff \
  #   > $SCANPATH.tiff & tiff2pdf -j -o $SCANPATH.pdf $SCANPATH.tiff'
  # '';
}

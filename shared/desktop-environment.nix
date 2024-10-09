{ config, ... }:

{
  # Desktop Environment crap
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager= {
    sddm.enable = true;
    defaultSession = "plasma";
  };
  programs.kdeconnect.enable = true; 
}
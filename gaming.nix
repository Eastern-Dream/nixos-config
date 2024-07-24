{ pkgs, ... }:

{
    # udev rules for tablets and controllers
    hardware.steam-hardware.enable = true;
    hardware.opentabletdriver.enable = true;
}

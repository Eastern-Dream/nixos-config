# Stuff I need for coursework, may radically change depending on what project I am in
# Not intended to be permanent part of a system configuration
{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers = {
    cs6290 = {
      image = "jsachs123/cs6290";
      autoStart = true;
      # ports = [ "2222:22" ];

      # login.username = "cs6290";
      # login.password = "cs6290user";
      # volumes = [ "cs6290:/home/cs6290" ];
    };
  };
}

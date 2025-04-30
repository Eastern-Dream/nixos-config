{ config, lib, ...}:

{
  config = lib.mkIf (config.identity.hostname == "workstation") {
    systemd.tmpfiles.rules = [ "L+ /home/${config.identity.username}/.config/mpv - - - - /etc/nixos/artifact/GLSL_Mac_Linux_High-end" ];
  };
}

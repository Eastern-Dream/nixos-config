{ config, lib, ...}:

{
  config = lib.mkIf (config.identity.hostname == "workstation") {
    # home-manager.users.${config.identity.username} = {
    #   home.file.".config/mpv" = {
    #     source = ../artifact/GLSL_Mac_Linux_High-end;
    #     recursive = true;
    #   };
    # };
    systemd.tmpfiles.rules = [ "L+ /home/${config.identity.username}/.config/mpv - - - - /home/${config.identity.username}/.dotfile/nixos-config/artifact/GLSL_Mac_Linux_High-end" ];
  };
}

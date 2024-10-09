{ config, ...}:

{
  home-manager.users.${config.identity.username} = {
    home.file.".config/mpv" = {
      source = ../artifact/GLSL_Mac_Linux_High-end;
      recursive = true;
    };
  };
}
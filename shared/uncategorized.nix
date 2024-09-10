{ config, ...}:

{
  home-manager.users.${config.identity.username} = {
    # MPV FSR shader
    # home.file.".config/mpv/shaders/FSR.glsl".source = ../artifact/FSR.glsl;
    # home.file.".config/mpv/input.conf".text = ''
    #   CTRL+1 no-osd change-list glsl-shaders set "~~/shaders/FSR.glsl"; show-text "FSR"
    #   CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
    # '';
    home.file.".config/mpv" = {
      source = ../artifact/GLSL_Mac_Linux_High-end;
      recursive = true;
    };
  };
}

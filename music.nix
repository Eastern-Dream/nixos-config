{ config, pkgs, ... }:

{
    # Music related packages
    users.users.${config.identity.username}.packages = with pkgs; [
      # System-wide EQ
      easyeffects

      # Player
      deadbeef

      # Dependencies
      opusTools
      lame

      # Tagger
      picard
    ];
}

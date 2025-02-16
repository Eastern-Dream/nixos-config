{ config, lib, pkgs, ... }:
# Common shared config that I want on PERMANENTLY for all systems
{
  imports =
    [
      # Add packages
      ./package.nix
      
      # Add localisation properties
      ./localisation.nix

      # Add some shell profile stuff
      ./shell-profile.nix

      # Add devenv
      ./devenv.nix

      # Add nix-ld to run unpatched binary, its not frequently used that much
      # ./nix-ld.nix

      # Desktop environment crap
      ./desktop-environment.nix

      # MPV Shader
      ./mpv-anime4k-shader.nix
    ];

  zramSwap.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable SSHD
  services.sshd.enable = true;

  # Need this for EasyEffects to work, among other things
  programs.dconf.enable = true;
  
  # Enable AppImage run wrapper
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.icu ];
    };
  };

  # tmpfiles for gitconfig
  systemd.tmpfiles.rules = [
    "f+ /home/${config.identity.username}/.gitconfig - - - - [user]\\nemail = ${config.identity.gitEmail}\\nname = ${config.identity.gitUsername}\\n[ssh]\\npostBuffer = 524288000\\n[url \"ssh://git@github.com/\"]\\ninsteadOf = https://github.com/"
  ];
}

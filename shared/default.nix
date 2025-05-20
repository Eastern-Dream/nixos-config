{ config, lib, pkgs, ... }:
# Common shared config that I want on PERMANENTLY for all systems
{
  imports =
    [
      # Add packages
      ./package.nix
      
      # Add localisation properties
      ./localisation.nix

      # Add devenv
      ./devenv.nix

      # Add nix-ld to run unpatched binary, its not frequently used that much
      ./nix-ld.nix  # Keep enabled for VSCode remote server

      # Desktop environment crap
      ./desktop-environment.nix

      # MPV Shader
      ./mpv-anime4k-shader.nix

      # bitwarden crap
      # ./bitwarden.nix
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

  programs.bash.blesh.enable = true;

  # tmpfiles for gitconfig
  systemd.tmpfiles.rules = [
    "f+ /home/${config.identity.username}/.gitconfig - - - - [user]\\nemail = ${config.identity.gitEmail}\\nname = Eastern-Dream\\n        signingkey = /home/${config.identity.username}/.ssh/bolt_cutter.pub\\n[ssh]\\npostBuffer = 524288000\\n[url \"ssh://git@github.com/\"]\\ninsteadOf = https://github.com/\\n\\n[commit]\\n        gpgsign = true\\n[gpg]\\n        format = ssh"
  ];
}

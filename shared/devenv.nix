{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = [
    unstable.devenv
  ];
  # devenv stuff
  nix.extraOptions = ''
    trusted-users = root ${config.identity.username}
    extra-substituters = https://nixpkgs-python.cachix.org https://devenv.cachix.org;
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw= nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU=;
  '';
  # direnv stuff
  programs.direnv.enable = true;
}
{ config, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in

{ 
  programs.ssh.startAgent = true;
  
  # lil env thing for bitwarden agent
  environment.sessionVariables = {
    SSH_AUTH_SOCK = "/home/${config.identity.username}/.bitwarden-ssh-agent.sock";
  };

  environment.systemPackages = [
    # Essential tools
    unstable.bitwarden-desktop
    unstable.bitwarden-cli
  ];
}
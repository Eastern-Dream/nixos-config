{ config, ...}:

{
    # Shell Profile stuff
    environment.interactiveShellInit = ''
        alias rebuild-switch='sudo nixos-rebuild switch -I nixos-config=/home/${config.identity.username}/.dotfile/nixos-config/configuration.nix'

        alias rebuild-boot='sudo nixos-rebuild boot -I nixos-config=/home/${config.identity.username}/.dotfile/nixos-config/configuration.nix'

        alias rebuild-upgrade='sudo nixos-rebuild boot --upgrade -I nixos-config=/home/${config.identity.username}/.dotfile/nixos-config/configuration.nix'

        find-nix-store() {
            if [ "$1" ]; then
                find /nix/store -maxdepth 1 -type d -name *$1*
            else
                echo "No argument supplied"
                exit 1
            fi
        }
    '';
}

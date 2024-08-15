{ config, pkgs, lib, ... }:

{
    imports = [
        ./vfio.nix
        ./looking-glass.nix
    ];

    options.virtualisation = {
        stack = lib.mkEnableOption "my virtualisation software stack";
        vboxKVM = lib.mkEnableOption "KVM-backend for VirtualBox";
        vfio = lib.mkEnableOption "VFIO";
        looking-glass = lib.mkEnableOption "VFIO";
    };

    config = lib.mkIf (config.virtualisation.stack) {

        home-manager.users.${config.identity.username} = {
            dconf.settings = {
                "org/virt-manager/virt-manager/connections" = {
                    autoconnect = ["qemu:///system"];
                    uris = ["qemu:///system"];
                };
            };
        };

        # Enable various virtualization features 
        programs.virt-manager.enable = true;
        virtualisation.libvirtd.enable = true;
        virtualisation.containers.enable = true;
        virtualisation.waydroid.enable = true;

        # VMWare section
        # virtualisation.vmware.host.enable = true;
        # boot.kernelParams = [ "transparent_hugepage=never" ];

        # VirtualBox section
        virtualisation.virtualbox.host = lib.mkMerge [

            {
            enable = true;
            # Long recompilation everytime, but needed for clipboard sharing for my config
            enableExtensionPack = true;
            }

            (lib.mkIf (config.virtualisation.vboxKVM) {
            # KVM backend requires no hardening therefore can run on 6.9+ kernel            
            enableKvm = true;
            enableHardening = false;
            addNetworkInterface = false;
            })
        ];

        environment.systemPackages = with pkgs; [
            podman
            distrobox
            virtiofsd
            quickemu
        ];
        
        # Add user to required group
        users.users.${config.identity.username}.extraGroups = [ "libvirtd" "user-with-access-to-virtualbox" "vboxusers"];
    };
}

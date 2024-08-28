{ config, pkgs, lib, ... }:

with lib;

{
    imports = [
        ./vfio.nix
        ./looking-glass.nix
    ];

    options.virtualisation = {
        stack = mkEnableOption "my virtualisation software stack";
        vboxKVM = mkEnableOption "KVM-backend for VirtualBox";
        vfio = mkEnableOption "VFIO";
        looking-glass = mkEnableOption "KVMFR Looking Glass capability";
    };

    config = mkIf (config.virtualisation.stack) {

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

        specialisation = { 
            virtualboxUseKVMBackend.configuration = {
                # KVM backend requires no hardening therefore can run on 6.9+ kernel  
                config.virtualisation.vboxKVM = mkDefault true;
            };
        };

        # VirtualBox section
        virtualisation.virtualbox.host = mkMerge [

            {
            enable = true;
            # Long recompilation everytime, but needed for clipboard sharing for my config
            enableExtensionPack = true;
            }

            (mkIf (config.virtualisation.vboxKVM) {
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

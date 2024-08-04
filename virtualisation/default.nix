{ config, pkgs, ... }:

{
    imports = [
        ./vfio.nix
    ];

    # Enable various virtualization features 
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.containers.enable = true;
    virtualisation.waydroid.enable = true;

    # VMWare section
    # virtualisation.vmware.host.enable = true;
    # boot.kernelParams = [ "transparent_hugepage=never" ];

    # VirtualBox section
    virtualisation.virtualbox.host = {
        enable = true;

        # Long recompilation everytime, but needed for clipboard sharing for my config
        enableExtensionPack = true;

        # KVM backend requires no hardening therefore can run on 6.9+ kernel
        enableKvm = true;
        enableHardening = false;
        addNetworkInterface = false;
    };

    environment.systemPackages = with pkgs; [
        podman
        distrobox
        virtiofsd
    ];
    
    # Add user to required group
    users.users.${config.identity.username}.extraGroups = [ "libvirtd" "user-with-access-to-virtualbox" "vboxusers"];
}

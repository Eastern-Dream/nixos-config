{ config, pkgs, lib, ... }:

{
    # Enable various virtualization features 
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.containers.enable = true;
    virtualisation.waydroid.enable = true;
    # virtualisation.vmware.host.enable = true;

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
        looking-glass-client
    ];
    
    # Add user to required group
    users.users.${config.identity.username}.extraGroups = [ "libvirtd" "user-with-access-to-virtualbox" "vboxusers"];


    # KVMFR kernel module
    boot.extraModulePackages = lib.mkIf (config.identity.hostname == "workstation") [ 
        pkgs.linuxKernel.packages.linux_zen.kvmfr 
    ];
    # tmpfile rule for looking glass IVSHMEM file
    systemd.tmpfiles.rules = lib.mkIf (config.identity.hostname == "workstation") [
        "f /dev/shm/looking-glass 0660 ${config.identity.username} kvm -"
    ];

    # IOMMU/VFIO/PCI Passthrough crap
    boot.kernelParams = lib.mkIf (config.identity.hostname == "workstation")[
        "intel_iommu=on"
    ];

    boot.initrd.kernelModules = lib.mkIf (config.identity.hostname == "workstation") [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
    ];

    # Hyper-V enlightenments and GPU passthrough modprobe, note that ids are hard-coded
    boot.extraModprobeConfig = lib.mkIf (config.identity.hostname == "workstation") ''
        options kvm_intel nested=1
        options kvm ignore_msrs=1
        softdep drm pre: vfio-pci
        options vfio-pci ids=10de:1d01,10de:0fb8
    '';
}

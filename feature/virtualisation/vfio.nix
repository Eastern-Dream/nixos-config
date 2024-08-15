{ config, pkgs, lib, ... }:

lib.mkIf (config.identity.hostname == "workstation") {
    environment.systemPackages = with pkgs; [
        looking-glass-client
    ];

    # KVMFR kernel module
    boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];

    services.udev.extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="${config.identity.username}", GROUP="kvm", MODE="0660"
    '';

    virtualisation.libvirtd.qemu.verbatimConfig = ''
        cgroup_controllers = [ "cpu", "memory", "blkio", "cpuset", "cpuacct" ]
    '';

    # IOMMU/VFIO/PCI Passthrough crap
    boot.kernelParams = [
        "intel_iommu=on"
    ];

    boot.initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
    ];

    boot.kernelModules = [
        "kvmfr"
    ];

    # Hyper-V enlightenments and GPU passthrough modprobe, note that ids are hard-coded
    boot.extraModprobeConfig = ''
        options kvm_intel nested=1
        options kvm ignore_msrs=1
        softdep drm pre: vfio-pci
        options vfio-pci ids=10de:1d01,10de:0fb8
    '';
}

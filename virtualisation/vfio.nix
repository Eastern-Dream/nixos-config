{ config, pkgs, lib, ... }:

lib.mkIf (config.identity.hostname == "workstation") {
    environment.systemPackages = with pkgs; [
        looking-glass-client
    ];

    # KVMFR kernel module
    boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];

    # tmpfile rule for looking glass IVSHMEM file
    systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 ${config.identity.username} kvm -"
    ];

    services.udev.extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="${config.identity.username}", GROUP="kvm", MODE="0660"
    '';

    virtualisation.libvirtd.qemu.verbatimConfig = ''
        cgroup_device_acl = [
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom",
            "/dev/ptmx", "/dev/kvm",
            "/dev/kvmfr0"
        ]
    '';

    # IOMMU/VFIO/PCI Passthrough crap
    boot.kernelParams = [
        "intel_iommu=on"
    ];

    boot.initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "kvmfr"
    ];

    # Hyper-V enlightenments and GPU passthrough modprobe, note that ids are hard-coded
    boot.extraModprobeConfig = ''
        options kvm_intel nested=1
        options kvm ignore_msrs=1
        softdep drm pre: vfio-pci
        options vfio-pci ids=10de:1d01,10de:0fb8
        options kvmfr static_size_mb=32
    '';
}

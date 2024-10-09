{ config, pkgs, lib, ... }:

{
    config = lib.mkIf (config.virtualisation.vfio-spec) {

        specialisation = let looking-glass-compatible-kernel = pkgs.linuxKernel.packages.linux_xanmod; in {
                use-vfio-looking-glass.configuration = {

                # KVMFR currently only work on 6.9 and below, force older kernel
                # xanmod has preempt dynamic, so it is okay to have preempt=full in params
                boot.kernelPackages = lib.mkForce looking-glass-compatible-kernel;
                boot.extraModulePackages = [ looking-glass-compatible-kernel.kvmfr ];
                boot.initrd.kernelModules = [ "kvmfr" ];
                environment.systemPackages = with pkgs; [ looking-glass-client ];

                # Re-enable nvidia gpu for passthrough
                disabledModules = [ <nixos-hardware/common/gpu/nvidia/disable.nix> ];

                # GPU passthrough modprobe, note that ids are hard-coded
                boot.extraModprobeConfig = ''
                    options kvmfr static_size_mb=32
                    softdep drm pre: vfio-pci
                    options vfio-pci ids=10de:1d01,10de:0fb8
                '';

                services.udev.extraRules = ''
                    SUBSYSTEM=="kvmfr", OWNER="${config.identity.username}", GROUP="kvm", MODE="0660"
                '';

                virtualisation.libvirtd.qemu.verbatimConfig = ''
                    cgroup_controllers = [ "cpu", "memory", "blkio", "cpuset", "cpuacct" ]
                '';

                home-manager.users.${config.identity.username} = {
                    home.file.".config/looking-glass/client.ini".text = ''
                        [app]
                        shmFile=/dev/kvmfr0
                    '';
                };
            };
        };
    };
}
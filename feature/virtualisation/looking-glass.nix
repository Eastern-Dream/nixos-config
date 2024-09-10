{ config, pkgs, lib, ... }:

{
    options.virtualisation.looking-glass= lib.mkEnableOption "KVMFR Looking Glass capability";

    config = lib.mkIf (config.virtualisation.looking-glass) {

        environment.systemPackages = with pkgs; [
            looking-glass-client
        ];

        # KVMFR kernel module
        boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];

        boot.initrd.kernelModules = [
            "kvmfr"
        ];

        boot.extraModprobeConfig = ''
            options kvmfr static_size_mb=32
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
}
{ config, pkgs, lib, ... }:

with lib;

{
    imports = [
        ./vfio.nix
        ./looking-glass.nix
    ];

    options.virtualisation = {
        stack = mkEnableOption "my virtualisation software stack";
        vboxKVM-spec = mkEnableOption "KVM-backend for VirtualBox specialisation";
        vfio-spec = mkEnableOption "VFIO specialisation";
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

        specialisation = { 
            virtualbox-use-KVM-backend.configuration = mkIf (config.virtualisation.vboxKVM-spec) {
                virtualisation.virtualbox.host = mkDefault {
                    enable = true;
                    # Long recompilation everytime, but needed for clipboard sharing for my config
                    enableExtensionPack = true;
                    enableKvm = true;
                    addNetworkInterface = false;
                };
            };
            use-vfio-looking-glass.configuration = mkIf (config.virtualisation.vfio-spec) {
                # KVMFR currently only work on 6.9 and below, force older kernel
                # xanmod has preempt dynamic, so it is okay to have preempt=full in params
                boot.kernelPackages = mkForce pkgs.linuxKernel.packages.linux_xanmod;
                virtualisation.vfio = true;
                virtualisation.looking-glass = true;
                # Re-enable nvidia gpu for passthrough
                disabledModules = [
                    <nixos-hardware/common/gpu/nvidia/disable.nix>
                ];
                # Unmount windows partition (the drive is also passthrough)
                # fileSystems."/mnt/windows-partition" = mkForce {};
            };
        };

        # Enable various virtualization features 
        programs.virt-manager.enable = true;
        virtualisation.libvirtd.enable = true;
        virtualisation.waydroid.enable = true;

        # Container section
        virtualisation.containers.enable = true;

        virtualisation.docker.storageDriver = "btrfs";
        virtualisation.docker.enable = true;
        virtualisation.oci-containers.backend = "docker";
        
        # virtualisation.podman = {
        #     dockerCompat = true;
        #     enable = true;
        # };
        # virtualisation.oci-containers.backend = "podman";

        # Useful other development tools
        environment.systemPackages = with pkgs; [
            dive # look into docker image layers
            podman-tui # status of containers in the terminal
            podman-compose

            lazydocker
            docker-compose # start group of containers for dev

            distrobox
            virtiofsd
            quickemu
        ];

        # VMWare section
        # virtualisation.vmware.host.enable = true;
        # boot.kernelParams = [ "transparent_hugepage=never" ];

        # VirtualBox section
        virtualisation.virtualbox.host = {
            enable = true;
            # Long recompilation everytime, but needed for clipboard sharing for my config
            enableExtensionPack = true;
        };
        
        # Add user to required group
        users.users.${config.identity.username}.extraGroups = [ "libvirtd" "user-with-access-to-virtualbox" "vboxusers" "docker" ];
    };
}

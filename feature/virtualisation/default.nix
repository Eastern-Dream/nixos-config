{ config, pkgs, lib, ... }:

with lib;

{
    imports = [
        ./looking-glass.nix
    ];

    options.virtualisation = {
        stack = mkEnableOption "my virtualisation software stack";
        vboxKVM-spec = mkEnableOption "KVM-backend for VirtualBox specialisation";
        vfio-spec = mkEnableOption "GPU Passthrough Looking Glass specialisation";
    };

    config = mkIf (config.virtualisation.stack) {

        # home-manager.users.${config.identity.username} = {
        #     dconf.settings = {
        #         "org/virt-manager/virt-manager/connections" = {
        #             autoconnect = ["qemu:///system"];
        #             uris = ["qemu:///system"];
        #         };
        #     };
        # };

        specialisation = mkIf (config.virtualisation.vboxKVM-spec) { 
            virtualbox-use-KVM-backend.configuration = {
                virtualisation.virtualbox.host = mkDefault {
                    enable = true;
                    # Long recompilation everytime, but needed for clipboard sharing for my config
                    enableExtensionPack = true;
                    enableKvm = true;
                    addNetworkInterface = false;
                };
            };
        };

        # Enable various virtualization features 
        programs.virt-manager.enable = true;
        virtualisation.libvirtd.enable = true;
        virtualisation.waydroid.enable = true;

        # Container section
        virtualisation.containers.enable = true;

        # virtualisation.docker.storageDriver = "btrfs";
        # virtualisation.docker.enable = true;
        # virtualisation.oci-containers.backend = "docker";
        
        virtualisation.podman = {
            dockerCompat = true;
            enable = true;
        };
        virtualisation.oci-containers.backend = "podman";

        # Useful other development tools
        environment.systemPackages = with pkgs; [
            dive # look into docker image layers
            podman-tui # status of containers in the terminal
            podman-compose

            #lazydocker
            #docker-compose # start group of containers for dev

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
            # enableExtensionPack = true;
        };

        # Hyper-V enlightenments
        boot.extraModprobeConfig = ''
            options kvm_intel nested=1
            options kvm ignore_msrs=1
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
        # Add user to required group
        users.users.${config.identity.username}.extraGroups = [ "libvirtd" "user-with-access-to-virtualbox" "vboxusers" "docker" ];
    };
}

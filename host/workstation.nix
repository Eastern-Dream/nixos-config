{ config , ... }:


{
  config = {

    virtualisation = {
      stack = true;
      vboxKVM-spec = false;
      vfio-spec = false;
    };

    # Fix a rare crash with my SSD model
    boot.kernelParams = [
      "nvme_core.default_ps_max_latency_us=0"
    ];

    fileSystems = {
      "/".options = [ "compress=zstd" ];
      "/run/media/${config.identity.username}/m482" = {
        device = "/dev/disk/by-uuid/09eef7c9-fd23-427a-9eba-f9c730516f2b";
        fsType = "btrfs";
        options = [ "compress=zstd" ];
      };
    };

  };
}

{ config , ... }:


{
  config = {

    virtualisation = {
      stack = true;
      vboxKVM-spec = true;
      vfio-spec = true;
    };

    # Fix a rare crash with my SSD model
    boot.kernelParams = [
      "nvme_core.default_ps_max_latency_us=0"
    ];

    # Mount other windows partition read-only
    fileSystems."/mnt/windows-partition" = {
      device = "/dev/disk/by-uuid/5E461FC3461F9ABB";
      fsType = "ntfs-3g"; 
      options = [ "ro" ];
    };

  };
}
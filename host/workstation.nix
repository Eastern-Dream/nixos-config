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

  };
}

{ config , ... }:


{
  config = {

    virtualisation = {
      stack = true;
      vboxKVM-spec = false;
      vfio-spec = false;
    };

    identity.hostname = "gram";
    # Fix the log spam by disabling a driver
    # https://www.reddit.com/r/linuxhardware/comments/x97m6l/comment/j2r7irr
    boot.extraModprobeConfig = ''
      blacklist int3403_thermal
    '';
    boot.kernelParams = [ 
      # The line below likely to not do anything
      #"acpi_mask_gpe=0x6E"
      # The LG Gram does not support s3 sleep, using it will cause imminent restart after wakeup!
      #"mem_sleep_default=deep"
    ];
    # Suspect the default suspend-then-hibernate has a funny complicated trigger so lets just force 1hr for now
    systemd.sleep.extraConfig = "HibernateDelaySec=1h";
  };
}
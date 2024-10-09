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
  };
}
{ config , ... }:


{
  config = {

    virtualisation = {
      stack = true;
      vboxKVM-spec = false;
      vfio-spec = false;
    };

    identity.hostname = "gram";
  };
}
{ config , lib , pkgs , ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
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

    # Navidrome music streaming server stuff
    systemd.services.navidrome.serviceConfig.ProtectHome = lib.mkForce false;
    services.navidrome = {
      enable = true;
      user = "roland";
      group = "users";
      settings = {
        MusicFolder = "/home/roland/Music/";
      };
    };
    
    # Specific mount option for my other drive
    fileSystems = {
      "/".options = [ "compress=zstd" ];
      "/run/media/${config.identity.username}/m482" = {
        device = "/dev/disk/by-uuid/09eef7c9-fd23-427a-9eba-f9c730516f2b";
        fsType = "btrfs";
        options = [ "compress=zstd" ];
      };
    };

    # Cloudflare tunnel for services
    services.cloudflared = {
      package = unstable.cloudflared;
      enable = true;
      tunnels = {
        "75ecfce5-82fc-4b78-b088-038d24c3c28d" = {
          credentialsFile = "/home/roland/.cloudflared/75ecfce5-82fc-4b78-b088-038d24c3c28d.json";
          default = "http_status:404";
        };
      };
    };

    # These are ssh settings for Cloudflare browser SSH
    services.openssh.settings = {
      KexAlgorithms = [
        "sntrup761x25519-sha512@openssh.com"
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group-exchange-sha256"
        "curve25519-sha256@libssh.org"
        "curve25519-sha256"
        "ecdh-sha2-nistp256"
        "ecdh-sha2-nistp384"
        "ecdh-sha2-nistp521"
      ];
      Macs = [
        "hmac-sha2-256"
        "hmac-sha2-512"
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];
    };
  };
}

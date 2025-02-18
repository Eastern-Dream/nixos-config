{ config, lib, ... }:

with lib;
{
  # All of these defaults to what workstation should have
  options.identity = {  
    username = mkOption {
      type = types.str;
      default = "roland";
      description = "My preferred username";
    };
    
    hostname = mkOption {
      type = types.str;
      default = "workstation";
      description = "My preferred hostname";
    };

    gitUsername = mkOption {
      type = types.str;
      default = "Eastern-Dream";
      description = "My preferred Git username";
    };
    gitEmail = mkOption {
      type = types.str;
      default = "eyrie@posteo.net";
      description = "My preferred Git email";
    };
  };

  imports = [
    # Only import one, comment out what isn't this system!
    # ./workstation.nix
    # dont care about nvidia thing anymore im done with looking glass
    # <nixos-hardware/common/gpu/nvidia/disable.nix>
    # ./gram.nix

  ];

}

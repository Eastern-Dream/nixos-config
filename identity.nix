{ lib, ... }:
with lib;
{
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
  };
}
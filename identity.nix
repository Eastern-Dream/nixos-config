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
}
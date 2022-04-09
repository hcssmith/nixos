{ config, pkgs, lib, ... }:
with lib;
let 
  cfg = config.homeConfig;
  userSetup = import ./fire
in {
  options = {
    homeConfig.enable = mkOption {
      type = types.bool;
      default = true;
      example = true;
      description = "Enable home-manage config (required for flakes)";
    };
    homeConfig.users = mkOption {
      default = {};
      type = with types; attrsOf (submodule userOpts);
    };
  };
  config = mkIf cfg.enable {
    home-manager.useGlobalPkgs = true;
    
  };
}

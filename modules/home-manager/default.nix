{ config, pkgs, lib, ... }:
with lib;
let cfg = config.homeConfig;
in {
  options = {
    homeConfig.enable = mkOption {
      type = types.bool;
      default = true;
      example = true;
      description = "Enable home-manage config (required for flakes)";
    };
  };
  config = mkIf cfg.enable {
    home-manager.useGlobalPkgs = true;
  };
}

{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.homeConfig;
  mkUserList = l: mapAttrs (name: value: (mkConfig value)) l;
  mkConfig = x: {
    home = {
      keyboard = null;
      packages = x.packages;
    };
    programs = { gpg.enable = true; };
    services = {
      gpg-agent = {
        enable = true;
        defaultCacheTtl = 10006400;
        pinentryFlavor = "qt";
      };
    };
  };
in {
  options = {
    homeConfig.enable = mkOption {
      type = types.bool;
      default = true;
      example = true;
      description = "Enable home-manage config (required for flakes)";
    };
    homeConfig.users = mkOption {
      default = { };
      type = with types; attrsOf (submodule (import ./user));
    };
  };
  config = mkIf cfg.enable {
    home-manager.useGlobalPkgs = true;
    home-manager.users = mkUserList cfg.users;
  };
}

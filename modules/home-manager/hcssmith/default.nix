{ config, pkgs, lib, ... }:
with lib;
let cfg = config.homeConfig.hcssmith;
in {
  options = {
    homeConfig.hcssmith = {
      enable = mkEnableOption "Enable hcssmith";
      packages = mkOption {
        type = types.listOf types.package;
        example = "with pkgs; [neovim]";
        default = [ ];
      };
    };
  };
  config = mkIf cfg.enable {
    home-manager.users.hcssmith = {
      home = {
        keyboard = null;
        packages = cfg.packages;
      };
      programs = { 
        gpg.enable = true; 
      };
      services = {
        gpg-agent = {
          enable = true;
          defaultCacheTtl = 10006400;
          pinentryFlavor = "qt";
        };
      };
    };
  };
}

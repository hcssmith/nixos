{ config, pkgs, lib, ... }:
with lib;
let cfg = config.customConfig;
in {
  options = {
    customConfig.enable = mkOption {
      type = types.bool;
      default = true;
      example = true;
      description = "Enable config (required for flakes)";
    };
  };
  config = mkIf cfg.enable {
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };
  time.timeZone = "Europe/London";
  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };
  };
}

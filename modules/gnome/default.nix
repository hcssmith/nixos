{ config, pkgs, lib, ... }:
with lib;
let cfg = config.customConfig.gnome;
in {
  options = { customConfig.gnome.enable = mkEnableOption "Enable gnome"; };
  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        layout = "gb";
        displayManager.gdm.enable = true;
        desktopManager.gnome = { enable = true; };
      };
    };
  };
}

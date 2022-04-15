{ config, pkgs, lib, ... }:
with lib;
let cfg = config.HCSAbstract.gnome;
in {
  options = { HCSAbstract.gnome.enable = mkEnableOption "Enable gnome"; };
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

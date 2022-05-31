{ config, pkgs, lib, ... }:
with lib;
let cfg = config.HCSAbstract.virt;
in {
  options = { HCSAbstract.virt.enable = mkEnableOption "Enable virtualbox"; };
  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "hcssmith" ];
  };
}

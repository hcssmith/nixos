{ config, pkgs, lib, ... }:
with lib;
let cfg = config.customConfig.users.hcssmith;
in {
  options = {
    customConfig.users.hcssmith.enable = mkEnableOption "Enable hcssmith";
  };
  config = {
    users.users.hcssmith = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
    };
  };
}

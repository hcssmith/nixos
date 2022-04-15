{ config, pkgs, lib, ... }:
with lib;
{
  options = {
      enable = mkEnableOption "Enable Email setup";
      address = mkOption {
        type = types.str;
        default = "";
        example = "email@example.com";
        description = "Email Address";
      };
      gpgSignKey = mkOption {
        type = types.str;
        default = "";
        description = "GPG Key for signing";
      };
      type = mkOption {
        type = types.str;
        default = "fastmail.com";
        description = "Email type";
      };
      name = mkOption {
        type = types.str;
        default = "Hallam SMith";
        description = "Full Name";
      };
      passwordGpg = mkOption {
        type = types.str;
        default = "";
        description = "Secret decrypt key";
      };
      secretLocation = mkOption {
        type = types.str;
        default = "hcssmith.com#secret";
        description = "Secret decrypt key";
      };
    };
}

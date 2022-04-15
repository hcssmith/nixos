{ lib, ... }:
with lib;
{
  options = {
    enable = lib.mkEnableOption "Use firefox";
    extensions = mkOption {
      type = (types.listOf types.package);
      default = [ ];
    };
    profiles = mkOption {
      default = { };
      type = with types; attrsOf (submodule (import ./profiles.nix));
    };
  };
}

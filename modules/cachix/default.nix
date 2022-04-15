{ config, pkgs, lib, ... }:

with lib;
let cfg = config.HCSAbstract.cachix;
in {
  options = {
    HCSAbstract.cachix.enable = mkEnableOption "Enable cachix configuration.";
  };

  config = mkIf cfg.enable {
    #environment.systemPackages = [ pkgs.cachix ]; #may be unneeded

    nix = {
      binaryCaches =
        [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
      binaryCachePublicKeys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR/master";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/master";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, nur, utils }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [ 
        self.overlay
        nur.overlay 
      ];

      overlay = import ./overlays;

      # Modules shared between all hosts
      hostDefaults.modules =
        [ home-manager.nixosModules.home-manager
        ./home/conf.nix
        ./hosts/base.nix
      ];

      hosts.eru.modules = [
        ./hosts/eru/eru.nix
        ./home/hcssmith.nix
        ./users/hcssmith.nix
        ./modules/gnome.nix
      ];
    };
}

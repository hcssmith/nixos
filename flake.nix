{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR/master";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.3.1";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, nur, utils, neovim-nightly-overlay }:
    let
      suites = import ./suites.nix { inherit utils; };
    in
    with suites;
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [ 
        self.overlay
        nur.overlay 
        neovim-nightly-overlay.overlay
      ];

      overlay = import ./overlays;

      hostDefaults.modules =
        [ home-manager.nixosModules.home-manager
      ] ++ HCSAbstract;

      hosts.eru.modules = [
        ./hosts/eru
      ]; 

      hosts.iluvatar.modules = [
        ./hosts/iluvatar
      ];
    };
}

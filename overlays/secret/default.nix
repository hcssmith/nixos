{ pkgs, buildGoModule, ... }:
buildGoModule {
  pname = "secret";
  name = "secret";
  version = "development";

  vendorSha256 = "sha256-H4xw+8vvCxQG/ZQBSxE62O1wSpICpeXqjXPzNBzZU1Y=";
  src = pkgs.fetchFromGitHub {
    owner = "hcssmith";
    repo = "secret";
    rev = "702045e87a9e05551ec3795728556c9242763f22";
    sha256 = "EewH+rFgFlyerbBJLmmDFoAPjec9r4Ov4cxBwvCRtK8=";
  };

}

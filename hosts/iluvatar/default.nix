{ ... }: {

  boot.isContainet = true;

  networking = { hostname = "iluvatar"; };

  services.nginx = { enable = true; };

}

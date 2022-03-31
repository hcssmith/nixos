{ ... }: {

  boot.isContainer = true;

  networking = { 
    hostName = "iluvatar"; 
    firewall.allowedTCPPorts = [80];
  };

  services = {
  nginx = { 
    enable = true;
    gitweb = {
      enable = true;
    };
    virtualHosts."hcssmith.com.local" = {
    root = "/var/www";
    };
  };
};

}

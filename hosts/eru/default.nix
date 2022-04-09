{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  customConfig = {
    cachix.enable = true;
    gnome.enable = true;
    users.hcssmith.enable = true;
  };

  homeConfig = {
    hcssmith = {
      enable = true;
      firefox.enable = true;
      packages = with pkgs; [ xclip neovide neovim-o github-desktop ];
      email = {
        enable = true;
        address = "me@hcssmith.com";
        name = "Hallam Smith";
        gpgSignKey = "DFE3DF82F116584A";
        passwordGpg = "0x6777079D642D66A8";
        secretLocation = "hcssmith.com#email";
        type = "fastmail.com";
      };
    };
  };

  networking = {
    hostName = "eru";
    hosts = { "10.233.1.2" = [ "hcssmith.com.local" ]; };
    networkmanager.enable = true;
    interfaces.wlp59s0.useDHCP = true;
  };

  system.stateVersion = "21.11"; # Did you read the comment?
}

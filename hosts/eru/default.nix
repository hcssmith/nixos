{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "eru";
    networkmanager.enable = true;
    interfaces.wlp59s0.useDHCP = true;
  };

  system.stateVersion = "21.11"; # Did you read the comment?
}
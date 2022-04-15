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
    enable = true;
    users = {
      hcssmith = {
        name = "hcssmith";
        enable = true;
        firefox = {
          enable = true;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            https-everywhere
            privacy-badger
            lastpass-password-manager
            ublock-origin
          ];

          profiles.hallam = {
            id = 0;
            isDefault = true;
            settings = {
              "browser.startup.homepage" =
                "https://duckduckgo.com/?kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kao=-1&kap=-1&kau=-1";
              "signon.rememberSignons" = true;
            };
            userChrome = builtins.readFile ../../config/firefox/chrome.css;
          };
        };
        packages = with pkgs; [ xclip neovide neovim-o github-desktop miranda ];
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
  };

  networking = {
    hostName = "eru";
    hosts = { "10.233.1.2" = [ "hcssmith.com.local" ]; };
    networkmanager.enable = true;
    interfaces.wlp59s0.useDHCP = true;
  };

  system.stateVersion = "21.11"; # Did you read the comment?
}

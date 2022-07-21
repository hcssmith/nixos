{ config, pkgs, lib, ... }:
with lib;
let cfg = config.HCSAbstract.userset.hcssmith;
in {
  options = {
    HCSAbstract.userset.hcssmith.enable = mkEnableOption "Enable hcssmith";
  };
  config = mkIf cfg.enable {
  users.users.hcssmith = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
    };
  HCSAbstract = {
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
            userChrome = builtins.readFile ../../../config/firefox/chrome.css;
          };
        };
        packages = with pkgs; [ xclip nx neovide neovim-o github-desktop git gnucash-o ];
        enableEmailConfig = true;

        email.hcssmith = {
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
  };
}

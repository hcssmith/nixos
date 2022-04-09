{ config, pkgs, lib, ... }:
with lib;
let cfg = config.homeConfig.hcssmith.email;
in {
  options = {
    homeConfig.hcssmith.email = {
      enable = mkEnableOption "Enable Email setup";
      address = mkOption {
        type = types.str;
        default = "";
        example = "email@example.com";
        description = "Email Address";
      };
      gpgSignKey = mkOption {
        type = types.str;
        default = "";
        description = "GPG Key for signing";
      };
      type = mkOption {
        type = types.str;
        default = "fastmail.com";
        description = "Email type";
      };
      name = mkOption {
        type = types.str;
        default = "Hallam SMith";
        description = "Full Name";
      };
      passwordGpg = mkOption {
        type = types.str;
        default = "";
        description = "Secret decrypt key";
      };
      secretLocation = mkOption {
        type = types.str;
        default = "hcssmith.com#secret";
        description = "Secret decrypt key";
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.hcssmith = {
      home.packages = with pkgs; [ secret st-o ];
      accounts.email.accounts = {
        hcssmith = {
          primary = true;
          address = "${cfg.address}";
          flavor = "${cfg.type}";
          gpg = {
            key = "${cfg.gpgSignKey}";
            signByDefault = true;
          };
          imap = {
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          smtp = {
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          notmuch = { enable = true; };
          mbsync = {
            enable = true;
            create = "maildir";
          };
          userName = "${cfg.address}";
          realName = "${cfg.name}";
          passwordCommand =
            "${pkgs.secret}/bin/secret -p ${cfg.secretLocation} -k ${cfg.passwordGpg}";
          msmtp.enable = true;
          astroid = { enable = true; };
        };
      };
      programs = {
        astroid = {
          enable = true;
          extraConfig = { editor.cmd = "st -w %3 -e nvim -- %1"; };
          pollScript = ''
            set -e
            mbsync -a
            notmuch new
          '';
        };
        notmuch = { enable = true; };
        mbsync = { enable = true; };
        msmtp = { enable = true; };
      };
      services = {
        mbsync = {
          enable = true;
          frequency = "*:0/1";
        };
      };
    };
  };
}

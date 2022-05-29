{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.HCSAbstract;
  mkUserList = l: mapAttrs (name: value: (mkConfig value)) l;
  mkFirefoxProfileList = l: mapAttrs (name: value: value) l;
  mkFirefoxConfig = x:
    mkIf x.firefox.enable {
      enable = true;
      extensions = x.firefox.extensions;
      profiles = mkFirefoxProfileList x.firefox.profiles;
    };
  mkEmailConfigList = l: mapAttrs (name: value: mkEmailConfig value) l;
  mkEmailConfig = x:
    mkIf x.enable {
      primary = true;
      address = x.address;
      flavor = x.type;
      gpg = {
        key = x.gpgSignKey;
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
      userName = x.address;
      realName = x.name;
      passwordCommand =
        "${pkgs.secret}/bin/secret -p ${x.secretLocation} -k ${x.passwordGpg}";
      msmtp.enable = true;
      astroid = { enable = true; };
    };
  mkConfig = x:
    mkIf x.enable {
      home = mkMerge [
        {
          keyboard = null;
          packages = x.packages;
        }
        (mkIf
        x.enableEmailConfig
        { packages = with pkgs; [ secret st-o ]; })

      ];
      accounts.email.accounts = mkEmailConfigList x.email;
      programs = mkMerge [
        {
          gpg.enable = true;
          firefox = mkFirefoxConfig x;
          vscode = {
            enable = true;
            package = pkgs.vscodium;    # You can skip this if you want to use the unfree version
            extensions = with pkgs.vscode-extensions; [
                # Some example extensions...
                ms-dotnettools.csharp
                dracula-theme.theme-dracula
            ];
          };
        }
        (mkIf x.enableEmailConfig
        {
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
        })
      ];
      services = mkMerge [
        (mkIf
        x.enableEmailConfig
        {
          mbsync = {
            enable = true;
            frequency = "*:0/1";
          };
        })
        {
          gpg-agent = {
            enable = true;
            defaultCacheTtl = 10006400;
            pinentryFlavor = "qt";
          };
        }
      ];
    };
in {
  options = {
    HCSAbstract.hm.enable = mkOption {
      type = types.bool;
      default = true;
      example = true;
      description = "Enable home-manage config (required for flakes)";
    };
    HCSAbstract.users = mkOption {
      default = { };
      type = with types; attrsOf (submodule (import ./user));
    };
  };
  config = mkIf cfg.hm.enable {
    home-manager.useGlobalPkgs = true;
    home-manager.users = mkUserList cfg.users;
  };
}

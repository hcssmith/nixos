{ config, pkgs, ... }:
let
  mynvim = with pkgs; [
    myNeovim
    neovide
    xclip
  ];
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [ 
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Europe/London";

  networking = {
    hostName = "eru";
    networkmanager.enable = true;
    interfaces.wlp59s0.useDHCP = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  services = {
    xserver = {
      enable = true;
      layout = "gb";
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hcssmith = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel" 
      "networkmanager"
    ]; 
  };
  home-manager.users.hcssmith = {
    home = {
      keyboard = null;
      packages = with pkgs; [
        github-desktop
      ] ++ mynvim;
    };
    programs = {
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
            "browser.startup.homepage" = "https://duckduckgo.com/?kae=d&kp=-2&kak=-1&kax=-1&kaq=-1&kao=-1&kap=-1&kau=-1";
            "signon.rememberSignons" = true;
          };
        };
      };
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs:
        with pkgs; rec {
          nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
            inherit pkgs;
          };
          myEmacs = emacsWithPackages (epkgs:
            (with epkgs.melpaStablePackages; [
              nix-mode
              nixos-options
              zerodark-theme
            ]));
          myNeovim = neovim.override {
            vimAlias = true;
            configure = {
              packages.myPlugins = with pkgs.vimPlugins; {
                start = [ 
                  vim-nix 
                  vim-csharp 
                  vim-go
                  vim-airline
                  vim-javascript
                  nerdtree
                  nvim-lspconfig
                  direnv-vim
                ];
              };

              customRC = builtins.readFile /etc/nixos/config/vim/init.vim;
            };
          };
        };
    };
  };

  system.stateVersion = "21.11"; # Did you read the comment?

}


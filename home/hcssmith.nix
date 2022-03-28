{ pkgs, ... }: {
  home-manager = {
    users.hcssmith = {
      home = {
        keyboard = null;
        packages = with pkgs; [ github-desktop neovide neovim-o xclip ];
      };
      programs = {
        gpg = { enable = true; };
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
            userChrome = builtins.readFile ../config/firefox/chrome.css;
          };
        };
      };
      services = {
        gpg-agent = {
          enable = true;
          defaultCacheTtl = 10006400;
          pinentryFlavor = "qt";
        };
      };
    };
  };

}

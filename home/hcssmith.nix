{ pkgs, ... }: {
  home-manager = {
    users.hcssmith = {
      home = {
        keyboard = null;
        packages = with pkgs; [ github-desktop neovide neovim-o xclip secret st-o ];
      };
      accounts.email.accounts = {
        hcssmith = {
          primary = true;
          address = "me@hcssmith.com";
          flavor = "fastmail.com";
          gpg = {
            key = "DFE3DF82F116584A";
            signByDefault = true;
          };
          imap = {
            host = "imap.fastmail.com";
            port = 993;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          smtp = {
            host = "smtp.fastmail.com";
            port = 465;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          notmuch = {
            enable = true;
          };
          mbsync = {
            enable = true;
            create = "maildir";
          };
          userName = "me@hcssmith.com";
          realName = "Hallam Smith";
          passwordCommand = "${pkgs.secret}/bin/secret -p hcssmith.com#email -k 0x6777079D642D66A8";
          msmtp.enable = true; 
          astroid = {
            enable = true;
          };
          neomutt = {
            enable = true;
            extraConfig = ''
              mailboxes =9front  =Archive  =bank  =Drafts  =Forwarded  =gopher-site  =Inbox  =linode  =mortgage  =Notes  =ovh  =Private  =Sent  =Snoozed  =Spam  =Templates  =Trash  =urbit  =WikiTribune
              set mail_check_stats
            '';
          };
        };
      };
      programs = {
        gpg = { enable = true; };
        astroid = { 
          enable = true;
          extraConfig = {
          editor.cmd = "st -w %3 -e nvim -c 'colorscheme darkblue' -- %1";
          };
          pollScript = ''
            set -e
            mbsync -a
            notmuch new
            '';
        };
        notmuch = {
          enable = true;
        };
        mbsync = {
          enable = true;
        };
        msmtp = {
          enable = true;
        };
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
        mbsync = {
          enable = true;
          frequency = "*:0/1";
        };
        gpg-agent = {
          enable = true;
          defaultCacheTtl = 10006400;
          pinentryFlavor = "qt";
        };
      };
    };
  };

}

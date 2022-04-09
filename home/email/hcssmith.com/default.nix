{pkgs, ...}:
{
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
          notmuch = { enable = true; };
          mbsync = {
            enable = true;
            create = "maildir";
          };
          userName = "me@hcssmith.com";
          realName = "Hallam Smith";
          passwordCommand =
            "${pkgs.secret}/bin/secret -p hcssmith.com#email -k 0x6777079D642D66A8";
          msmtp.enable = true;
          astroid = { enable = true; };
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
}

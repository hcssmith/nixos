{ config, pkgs, ... }:
let
  mynvim = with pkgs; [
    myNeovim
    neovide
    xclip
    nixfmt
    omnisharp-roslyn
    rnix-lsp
    gopls
  ];
in
{
  imports = [ 
    ./hardware-configuration.nix
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
      "docker"
    ]; 
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    firefox
    github-desktop
    go
  ] ++ mynvim;

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs:
        with pkgs; rec {
          myEmacs = emacsWithPackages (epkgs:
            (with epkgs.melpaStablePackages; [
              nix-mode
              nixos-options
              zerodark-theme
              omnisharp
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
                  LanguageClient-neovim 
                  vim-javascript
                  nerdtree
                ];
              };
              customRC = ''
                set number
                set nowrap
                set tabstop=4
                set mouse=a
                set clipboard=unnamedplus

                let NERDTreeChDirMode=2

                set guifont=Source\ Code\ Pro\ Mono:h10
                
                inoremap jk <Esc>

                nmap <silent> <A-Up> :wincmd k<CR>
                nmap <silent> <A-Down> :wincmd j<CR>
                nmap <silent> <A-Left> :wincmd h<CR>
                nmap <silent> <A-Right> :wincmd l<CR>

                set backupdir=/tmp
                set directory=/tmp

                let g:LanguageClient_serverCommands = {
                  \ 'cs': ['${omnisharp-roslyn}/bin/omnisharp', '-lsp'],
                  \ 'nix': ['${rnix-lsp}/bin/rnix-lsp'],
                  \ 'go': ['${gopls}/bin/gopls']
                  \ }

                nnoremap <F5> :call LanguageClient_contextMenu()<CR>
                nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
                nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
                nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
                nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
                nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
                nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

                autocmd StdinReadPre * let s:std_in=1
                autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
                autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
                autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
                  \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
                autocmd BufWinEnter * if getcmdwintype() == ''\'''\' | silent NERDTreeMirror | endif
              '';
            };
          };
        };
    };
  };

  system.stateVersion = "21.11"; # Did you read the comment?

}


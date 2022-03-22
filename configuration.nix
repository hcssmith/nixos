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
    ]; 
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    firefox
    github-desktop
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
                  vim-javascript
                  nerdtree
                  nvim-lspconfig
                  direnv-vim
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

                nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
                nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>
                nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
                nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
                nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
                nnoremap <silent> <space>wa :lua vim.lsp.buf.add_workspace_folder()<CR>

                nnoremap <silent> <C-k> :lua vim.lsp.buf.signature_help()<CR>
                nnoremap <silent> <space>wr :lua vim.lsp.buf.remove_workspace_folder()<CR>
                nnoremap <silent> <space>wl :lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
                nnoremap <silent> <space>D :lua vim.lsp.buf.type_definition()<CR>
                nnoremap <silent> <space>rn :lua vim.lsp.buf.rename()<CR>
                nnoremap <silent> <space>ca :lua vim.lsp.buf.code_action()<CR>
                nnoremap <silent> <space>f :lua vim.lsp.buf.formatting()<CR>

                nnoremap <silent> <space>e :lua vim.diagnostic.open_float()<CR>
                nnoremap <silent> [d :lua vim.diagnostic.goto_prev()<CR>
                nnoremap <silent> ]d :lua vim.diagnostic.goto_next()<CR>
                nnoremap <silent> <space>q :lua vim.diagnostic.setloclist()<CR>

                set omnifunc=v:lua.vim.lsp.omnifunc

                lua << EOF

                  local servers = { 'gopls', 'rnix' }
                  for _, lsp in pairs(servers) do
                    require('lspconfig')[lsp].setup {
                      on_attach = on_attach,
                      flags = {
                        debounce_text_changes = 150,
                      }
                    }
                  end
                EOF

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


{ pkgs, neovim }:
neovim.override {
  vimAlias = true;
  configure = {
    packages.myPlugins = with pkgs.vimPlugins; {
      start = [
        vim-nix
        vim-csharp
        vim-go
        vim-airline
        vim-javascript
        vim-airline
        vim-airline-themes
        NeoSolarized
        nerdtree
        nvim-lspconfig
        direnv-vim
      ];
    };

    customRC = builtins.readFile ./init.vim;
  };
}


final: prev: {
  neovim-o = prev.callPackage ./neovim { };
  secret = prev.callPackage ./secret{ };
  st-o = prev.callPackage ./st { };
  vim-miranda = prev.callPackage ./vimPlugins/vim-miranda.nix { };
}

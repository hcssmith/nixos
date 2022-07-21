final: prev: {
  neovim-o = prev.callPackage ./neovim { };
  nx = prev.callPackage ./nx { };
  secret = prev.callPackage ./secret{ };
  st-o = prev.callPackage ./st { };
  gnucash-o = prev.callPackage ./gnucash { };
  vimPlugins = prev.vimPlugins // import ./vimPlugins {inherit prev;};
}

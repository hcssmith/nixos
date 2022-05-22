final: prev: {
  neovim-o = prev.callPackage ./neovim { };
  nx = prev.callPackage ./nx { };
  secret = prev.callPackage ./secret{ };
  st-o = prev.callPackage ./st { };
  vimPlugins = prev.vimPlugins // import ./vimPlugins {inherit prev;};
}

{pkgs, fetchFromGitHub, ...}:
pkgs.vimUtils.buildVimPlugin {
  name = "vim-miranda";
  src = fetchFromGitHub {
    owner = "zlahham";
    repo = "vim-miranda";
    rev = "ecddb1abf8afa14ab5b8a923892e21ad4bed98ea";
    sha256 = "Ei0I/z4Dhfyobt6AF0oEuqXHnCAl4MDQFKyWYB/SApo=";
  };
}

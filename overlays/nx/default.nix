{ lib, stdenv, fetchurl, writeText, tcl }:

tcl.mkTclDerivation rec {
  pname = "next-script";
  version = "2.3.0";

  src = fetchurl {
    url = "https://netcologne.dl.sourceforge.net/project/next-scripting/${version}/nsf${version}.tar.gz";
    sha256 = "1abvzmf1hq3hymx2amsinv6w6qzmk1a1jz6mr2x0m40q1v0c8h1r";
  };

  enableParallelBuilding = true;

}

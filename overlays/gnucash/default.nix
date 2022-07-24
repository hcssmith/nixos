{pkgs, gnucash, fetchurl, ...}:
gnucash.overrideAttrs (oldAttrs: rec{
  version = "4.10";
  src = fetchurl {
    url = "https://github.com/Gnucash/gnucash/releases/download/${version}/${oldAttrs.pname}-${version}.tar.bz2";
    sha256 = "0fy9p5fgi2i0x7acg5fnkfdrxxd3dypi3ykvnj53hfbfky8vpm3z";
  };
})

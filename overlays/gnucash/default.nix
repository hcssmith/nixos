{pkgs, gnucash, fetchurl, ...}:
gnucash.overrideAttrs (oldAttrs: rec{
  version = "4.11";
  src = fetchurl {
    url = "https://github.com/Gnucash/gnucash/releases/download/${version}/${pname}-${version}.tar.bz2";
    hash = "069b216dkpjs9hp32s4bhi6f76lbc81qvbmjmz0dxq3v1piys57q";
  };
})

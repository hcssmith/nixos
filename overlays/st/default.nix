{pkgs, st, fetchFromGitHub, ...}:
st.overrideAttrs (oldAttrs: rec{
  src = fetchFromGitHub {
    owner = "hcssmith";
    repo = "st";
    rev = "1c9006b7c15fa2026f8363dff4112516099848b2";
    sha256 = "8Kz18ebf2MhW3Y9QxKsZQonpHpNrj7IPmBZFqov3iFo=";
  };
})

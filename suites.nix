{utils}:
let
  customConfig = utils.lib.exportModules [
    ./modules/cachix 
    ./modules/gnome
    ./modules/users/hcssmith
  ];

  home-managerConfig = utils.lib.exportModules [
    ./modules/home-manager
    ./modules/home-manager/email
    ./modules/home-manager/hcssmith
    ./modules/home-manager/firefox
  ];

  sharedConfig = with customConfig; [
    cachix
    hcssmith
  ];
  desktopConfig = with customConfig; [
    gnome
  ];
  homeConfig = with home-managerConfig; [
    email
    home-manager
    hcssmith
    firefox
  ];
in
  {
    inherit sharedConfig desktopConfig homeConfig;
  }
  

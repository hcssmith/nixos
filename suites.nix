{utils}:
let
  osConfig = utils.lib.exportModules [
    ./modules/base
    ./modules/cachix 
    ./modules/gnome
    ./modules/virt
  ];

  userConfig = utils.lib.exportModules [
    ./modules/home-manager
    ./modules/users/hcssmith
  ];

  HCSAbstract = with osConfig; [
    cachix
    base
    gnome
    virt
  ] ++ [
    userConfig.home-manager
    userConfig.hcssmith
  ];
in
  {
    inherit HCSAbstract;
  }
  

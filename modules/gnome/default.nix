{ ... }: {
  services = {
    xserver = {
      enable = true;
      layout = "gb";
      displayManager.gdm.enable = true;
      desktopManager.gnome = { enable = true; };
    };
  };
}

move to submodule based config (for multi user setup) demo in users

in homeConfig have hcssmith come accross as a submod


homeConfig.users.<username>.
		enable
		packages
		firefox
		email

homeConfig = {
		hcssmith = {
				enable = true;
				email = {
						...
				}
				packages = with pkgs; [neovim];
				firefox = {enable = true;};
		};
};

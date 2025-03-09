{ pkgs, lib, ...}:

{

	programs.nvf = {
		enable = true;
		settings = {
			vim = {
				theme = {
					enable = true;
					name = "gruvbox";
					style = "dark";
				};
				languages.nix.enable = true;
			};
		};
	};
};

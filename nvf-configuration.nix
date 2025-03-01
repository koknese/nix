{ pkgs, lib, ...}:

{
   vim = {
	statusline.lualine.enable = true;
   	telescope.enable = true;
   	autocomplete.nvim-cmp.enable = true;

	languages = {
	   enableLSP = true;
	   enableTreesitter = true;
	};
   };
}


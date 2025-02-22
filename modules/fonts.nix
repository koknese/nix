{ pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
	noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-emoji
  	liberation_ttf
  	dina-font
    ];

  fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}


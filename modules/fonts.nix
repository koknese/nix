{ pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
	noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-emoji
  	liberation_ttf
  	dina-font
    ];

    fonts.packages = with pkgs; [
	  nerd-fonts.anonymice
	  nerd-fonts.lekton
	  nerd-fonts.blex-mono
	  nerd-fonts.symbols-only
	  league-gothic
	  inter
    ];
}


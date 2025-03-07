{ pkgs, lib, inputs, ... }:

{
  home-manager.users.dainis = { pkgs, ... }: {
        home.stateVersion = "25.05";
	programs.firefox = {
	  enable = true;
	  package = pkgs.librewolf;
	  policies = {
	    DisableTelemetry = true;
	    DisableFirefoxStudies = true;
	    Preferences = {
	      "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
	      "cookiebanners.service.mode" = 2; # Block cookie banners
	      "privacy.donottrackheader.enabled" = true;
	      "privacy.fingerprintingProtection" = true;
	      "privacy.resistFingerprinting" = true;
	      "privacy.trackingprotection.emailtracking.enabled" = true;
	      "privacy.trackingprotection.enabled" = true;
	      "privacy.trackingprotection.fingerprinting.enabled" = true;
	      "privacy.trackingprotection.socialtracking.enabled" = true;
	    };
  	  };
        };
	programs.vscode = {
	  enable = true;
	  package = pkgs.vscodium.fhs;
	};

	programs.kitty = {
	   enable = true;
	   font = {
	      package = pkgs.nerd-fonts.lekton;
	      name = "Lekton Nerd Font";
	      size = 16;
	   };
	};

	home.packages = with pkgs; [
	    vesktop
            noto-fonts
            pavucontrol
            #pywal16
            tealdeer
            thefuck
            pywalfox-native
            zoxide
            git
            ncdu
            pamixer
	    lmms
            
	    vlc
            unzip
	    lutris
	    qbittorrent-enhanced
	];
	xsession.windowManager.i3 = rec {
	       enable = true;
	       package = pkgs.i3;
	       config = {
	         modifier = "Mod4";
	
		keybindings = import ./i3-keybinds.nix config.modifier;
		bars = [ ];
	
	         gaps = {
	           inner = 10;
	           outer = 5;
	         };

		 window.titlebar = false;
		 defaultWorkspace = "workspace number 1";
		
		fonts = {
		  names = [ "AnonymicePro Nerd Font" ];
		  size = 11.0;
		};
		
		startup = [
		   { command = "nohup bash -c ''cd ~/Shells/Python && nix-shell --run ''source ~/venv/bin/activate && discordrp-mpris''' > output.log 2>&1 &"; }
		   { command = "polybar"; }
		   { command = "dunst"; }
		   { command = "feh --bg-fill ~/Downloads/wallpaper.png"; }
		 ];
	       };
	       extraConfig = "
		set_from_resource $fg i3wm.color7 #f0f0f0\n
		set_from_resource $bg i3wm.color2 #f0f0f0\n
		
		client.focused          $bg     $bg     $fg  $bg       $bg\n
		client.focused_inactive $bg     $bg     $fg  $bg       $bg\n
		client.unfocused        $bg     $bg     $fg  $bg       $bg\n
		client.urgent           $bg     $bg     $fg  $bg       $bg\n
		client.placeholder      $bg     $bg     $fg  $bg       $bg\n
		
		client.background       $bg\n
	       ";
	     };
   };
}

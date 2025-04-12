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

	programs.zsh = {
	   enable = true;
  	   enableCompletion = true;
	   sessionVariables = {
	      PROMPT = "[%~]> ";
	      SUDO_EDITOR = "vim";
	   };
	   initExtra = ''
	      (cat ~/.cache/wal/sequences &)
	      source ~/.cache/wal/colors-tty.sh
      	      eval $(thefuck --alias)
	      eval "$(zoxide init zsh)"

	      autoload -Uz compinit && compinit
	      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
           '';
  	   zplug = {
  	     enable = true;
  	     plugins = [
		#
  	     ];
  	   };
	};

	programs.kitty = {
	   enable = true;
	   font = {
	      package = pkgs.nerd-fonts.lekton;
	      name = "Lekton Nerd Font";
	      size = 16;
	   };
	   settings = {
	      window_padding_width = 12;
	   };
	};

	home.packages = with pkgs; [
	    vesktop
            pavucontrol
            pywal16
            tealdeer
            thefuck
            pywalfox-native
            zoxide
            git
            ncdu
            pamixer
            
            unzip
   	    krita
	    prismlauncher
	ventoy
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
		   { command = "polybar"; }
		   { command = "cd ~/Gits/vlc-rpc/ && start.sh"; }
		   { command = "dunst"; }
		   { command = "keepassxc"; }
		   { command = "nicotine"; }
		   { command = "picom"; }
		   { command = "feh --bg-center ~/Downloads/wallpaper.jpg"; }
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

		mode `resize` {\n
        		bindsym j resize shrink width 10 px or 10 ppt\n
        		bindsym k resize grow height 10 px or 10 ppt\n
        		bindsym l resize shrink height 10 px or 10 ppt\n
        		bindsym semicolon resize grow width 10 px or 10 ppt\n

        		bindsym Left resize shrink width 10 px or 10 ppt\n
        		bindsym Down resize grow height 10 px or 10 ppt\n
        		bindsym Up resize shrink height 10 px or 10 ppt\n
        		bindsym Right resize grow width 10 px or 10 ppt\n

        		bindsym Return mode `default`\n
        		bindsym Escape mode `default`\n
        		bindsym $mod+r mode `default`\n
		}
	       ";
	     };
	     programs = {
    		direnv = {
    		  enable = true;
    		  enableBashIntegration = true; # see note on other shells below
    		  nix-direnv.enable = true;
    		};

    		bash.enable = true; # see note on other shells below
	};
   };
}

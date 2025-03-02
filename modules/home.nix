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
   };
}

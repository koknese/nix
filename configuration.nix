# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
      # Fonts
	./modules/fonts.nix
	./modules/home.nix
	inputs.home-manager.nixosModules.home-manager
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Cleaning out bloat and freeing up space
  boot.tmp.cleanOnBoot = true; # wipes /tmp on boot
  services.journald.extraConfig = "SystemMaxUse=200M"; # Limits /var/log/journal to 200 MiB

  networking.hostName = "muldakmens"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
	
  programs.thunar.enable = true;
  programs.steam.enable = true;
  #services.flatpak.enable = true;
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = with pkgs; [
  #      xdg-desktop-portal-gtk
  #];

  # Set your time zone.
  time.timeZone = "Europe/Riga";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable i3wm.
  services.xserver = { 
     displayManager.lightdm.enable = true;
     windowManager.i3.enable = true;
     windowManager.i3.extraPackages = with pkgs; [
        rofi
        polybar
        i3lock-fancy-rapid
        kdePackages.spectacle
        feh
        dunst
     ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "lv";
    variant = "apostrophe";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;
  services.tor.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;

  programs.adb.enable = true;

  users.users.dainis = {
    isNormalUser = true;
    description = "dainis";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
      vlc
      picom
      nicotine-plus
      keepassxc
      obs-studio
      tor-browser
    ];
  };

  programs.git.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
  
  programs.zsh = {
	enable = true;
	syntaxHighlighting.enable = true;
	autosuggestions.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	wget
     	killall
     	python3
	htop-vim
	bun
	nodejs
	sqlite
	# Flakes
  ];
  
  home-manager.backupFileExtension = ".bak";

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

}

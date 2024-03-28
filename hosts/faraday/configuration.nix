# Faraday - configuration.nix

{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "faraday"; 
  networking.networkmanager.enable = true;
  
  # Localization
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # if you want to user JACK applications, uncomment this:
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so
    # this is enabled by default, no need to redefine it in your config
    # for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled by default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account
  users.users.evelyn = {
    isNormalUser = true;
    description = "Evelyn King";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with
    pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable an insecure electron version
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  # Packages installed in the system profile.
  environment.systemPackages = with pkgs; [
    git
    htop
    vim
    wget
  ];

  # Some programs need SUID wrappers
  # programs.mtr.enable = true;
  # programs.gnugp.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [
  #   ...
  # ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the
  # default settings for stateful data, line file locations
  # and database versions on your system were taken. It's
  # perfectly fine and recommended to leaves this value at the release
  # version of the first install of this system. Before changing
  # this value, read the documentation for this option (e.g. man
  # configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";

}

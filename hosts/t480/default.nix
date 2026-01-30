{ pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "t480";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Istanbul"; 
  i18n.defaultLocale = "en_US.UTF-8";

  # Compositor (Wayland)
  programs.river.enable = true;

  # Core Packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    foot
    waybar
    dmenu-rs
    brightnessctl


    git
    neovim
    foot
    waybar
    rofi-wayland      # Better looking, icon support, scriptable
    brightnessctl
    pavucontrol
    libnotify
  ];

  # User Account (Replace 'yourusername' with yours)
  users.users.s3c = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
  };

  # Power Management for T480
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };
  

  # Hibernation Logic
  # Note: We will define the actual swap device in hardware.nix later
  boot.resumeDevice = "/dev/nvme0n1p2"; # Placeholder: we'll fix this during install
  
  # Disable zram since you prefer a physical swap for hibernation
  zramSwap.enable = false;

  system.stateVersion = "24.05";
}

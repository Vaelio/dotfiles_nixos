# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/p14s>
      ./hardware-configuration.nix
    ];

  # Enable AMD microcode update
  hardware.cpu.amd.updateMicrocode = true;

  # backup configuration
  system.copySystemConfiguration = true;

  # TODO check if this is latest version
  nix.package = pkgs.nixVersions.latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" "CONFIG_VHOST_VSOCK=m"];

  networking.hostName = "FOR-M388"; # Define your hostname.
  networking.useDHCP = false; # much better for pentesting
  networking.enableIPv6  = false;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # add swap to prevent some freezes maybe
  swapDevices = [ {
    device = "/var/lib/swapfile";
    randomEncryption.enable = true;
    size = 16*1024;
  } ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  

  # Enable networking
  networking.networkmanager.enable = false;
  networking.wireless.iwd.enable = true;

  networking.extraHosts = 
    ''
    '';


  # Custom udev for vial
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  # enable thinkfan (fan stuff for thinkpad)
  # services.thinkfan.enable = true;

  # enable polkit
  security.polkit.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  # enable libvirtd
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  # hardware acceleration
  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.rocmPackages.clr.icd
      pkgs.amdvlk
    ];
    extraPackages32 = [
      pkgs.driversi686Linux.amdvlk
    ];
  };
  environment.variables.AMD_VULKAN_ICD = "RADV";
  #---



  # enable docker
  virtualisation.docker.enable = true;

  # enable flatpak
  services.flatpak.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  #virtualisation.docker.rootless = {
  #  enable = true;
  #  setSocketVariable = true;
  #};
  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vaelio = {
    isNormalUser = true;
    description = "vaelio";
    extraGroups = [ "wheel" "libvirtd" "wireshark" "arduino"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    iwd
    wget
    curl
    busybox
    git
    innernet
    vim
  ];

  fonts.packages = with pkgs;[
  ];

  systemd.ctrlAltDelUnit="";
  systemd.services.ctrl-alt-del.wantedBy = lib.mkForce [];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.uwsm.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.earlyoom.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

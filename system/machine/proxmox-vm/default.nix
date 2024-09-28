{ pkgs, ... }:

{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
    ../../wm/xmonad.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    systemd-boot.enable = false;
    grub = {
      enable = true;
      enableCryptodisk = true;
      device = "/dev/sda";
    };

    initrd = {
      enable = true;
      luks.devices = {
        root = {
          device = "/dev/disk/by-uuid/2c5020ce-9f22-4528-a278-afa62a9258ce";
          preLVM = false;
        };
      };
    };
  };

  # Enable networking
  networking.hostName = "proxmox-vm";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

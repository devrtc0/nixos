{ lib, config, ... }:

{
  imports = [ ];

  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "nvme" "sr_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" =
      {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
      };
    "/boot" =
      {
        device = "/dev/disk/by-label/boot";
        fsType = "vfat";
      };
  };

  swapDevices = [ ];

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "vm";
    dhcpcd = {
      wait = "background";
      extraConfig = "noarp";
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  virtualisation.virtualbox.guest.enable = true;
}

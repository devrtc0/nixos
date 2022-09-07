{ lib, config, ... }:

{
  imports = [ ];

  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "xhci_pci" "nvme" "sr_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
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

  hardware.cpu.intel.updateMicrocode = true;
}

{ lib, config, ... }:

{
  imports = [ ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sr_mod" "i915" "iwlwifi" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
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

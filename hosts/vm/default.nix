{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
        };
      };
      desktopManager = {
        plasma5 = {
          enable = true;
          excludePackages = with pkgs; [
            plasma5Packages.elisa
          ];
        };
      };
      autoRepeatDelay = 300;
      autoRepeatInterval = 30;
      layout = "us,ru";
      xkbModel = "pc105";
      xkbOptions = "terminate:ctrl_alt_bksp,grp:win_space_toggle";
      excludePackages = with pkgs; [
        xterm
      ];
    };
  };
  environment = {
    systemPackages = with pkgs; [
      qbittorrent
      kate
    ];
  };
}

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
      layout = "us,ru";
      displayManager = {
        gdm = {
          enable = true;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };
  environment = {
    gnome.excludePackages = (with pkgs; [
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      epiphany # web browser
    ]);
  };
}

{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "http://10.0.2.2:4444/"
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
        gdm = {
          enable = true;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
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
    gnome = {
      excludePackages = (with pkgs; [
        gnome-tour
        gnome-photos
      ]) ++ (with pkgs.gnome; [
        epiphany
        geary
        cheese
        gnome-music
        gnome-calendar
        gnome-weather
      ]);
    };
    systemPackages = (with pkgs; [
      gnome-solanum
    ]) ++ (with pkgs.gnome; [
      gedit
      gnome-tweaks
    ]);
  };
}

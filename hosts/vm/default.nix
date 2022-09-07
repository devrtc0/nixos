{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "http://10.0.2.2:4444/"
  ];

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
    dnsmasq = {
      servers = [
        "8.8.4.4"
      ];
    };
  };
  networking = {
    hostName = "vm";
  };
  virtualisation = {
    virtualbox.guest.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
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
      gnome-tweaks
    ]);
  };
}

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
        sddm = {
          enable = true;
        };
      };
      desktopManager = {
        plasma5 = {
          enable = true;
        };
        xterm = {
          enable = false;
        };
      };
      autoRepeatDelay = 300;
      autoRepeatInterval = 30;
      layout = "us,ru";
      xkbModel = "pc105";
      xkbOptions = "terminate:ctrl_alt_bksp,grp:win_space_toggle";
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
    systemPackages = with pkgs; [
      kde-gtk-config
    ];
  };
}

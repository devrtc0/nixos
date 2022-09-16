{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  services = {
    throttled = {
      enable = true;
    };
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
      extraConfig = ''
        server=/vdi.vtb.ru/10.230.192.77
        server=/vdi.vtb.ru/10.230.192.78
        server=/region.vtb.ru/10.230.192.77
        server=/region.vtb.ru/10.230.192.78
        server=/corp.dev.vtb/10.230.192.77
        server=/corp.dev.vtb/10.230.192.78
        server=/vtb.grp/10.230.192.77
        server=/vtb.grp/10.230.192.78
      '';
    };
  };
  networking = {
    hostName = "t15g1";
  };
  virtualisation = {
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
      gnome-solanum # pomodoro timer
    ]) ++ (with pkgs.gnome; [
      gnome-tweaks
    ]);
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}

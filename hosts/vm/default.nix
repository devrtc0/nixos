{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "http://192.168.3.188:4444/"
  ];

  networking = {
    hostName = "vm";
    firewall.enable = false;
  };
  environment = {
    systemPackages = with pkgs; [
    ];
  };
  virtualisation.virtualbox = {
    guest = {
      enable = true;
    };
  };
  services = {
    tailscale = {
      enable = true;
    };
  };
  users.users.azat.extraGroups = [ "vboxusers" "vboxsf" ];
}

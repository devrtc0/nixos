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
  };
  environment = {
    systemPackages = with pkgs; [
      ];
  };
  virtualisation.virtualbox.host = {
    headless = true;
    enableExtensionPack = true;
  };
}

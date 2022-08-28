{ lib, pkgs, ... }: {
  time = {
    timeZone = "Europe/Samara";
  };
  system = {
    stateVersion = "22.11";
  };
  environment = {
    systemPackages = with pkgs; [
      git
      slack
    ];
  };
}

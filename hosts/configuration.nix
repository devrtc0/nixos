{ lib, ... }: {
  time = {
    timeZone = "Europe/Samara";
  };
  system = {
    stateVersion = "22.11";
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

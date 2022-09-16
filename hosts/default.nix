{ nixpkgs, home-manager, version, system, ... }:
let
  lib = nixpkgs.lib;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      hardware.firmware = [
        "linux-firmware"
      ];
    };
    overlays = [
      (import (builtins.fetchGit {
        rev = "c85e6cc95333ca73139c756d80a6e0c6dfb4935e";
        url = "https://github.com/devrtc0/nix-overlays.git";
      }))
    ];
  };
in
{
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit version pkgs; };
    modules = [
      ./configuration.nix
      ./vm

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit version pkgs; };
          users.user = {
            imports = [ (import ./home.nix) ] ++ [ (import ./vm/home.nix) ];
          };
        };
      }
    ];
  };
}

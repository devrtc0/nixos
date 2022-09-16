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
        rev = "7c1610f51987810ff5673a163881bcb8858c2d5e";
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

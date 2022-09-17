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
  vm1 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit version pkgs; };
    modules = [
      ./configuration.nix
      ./vm1

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit version pkgs; };
          users.user = {
            imports = [ (import ./home.nix) ] ++ [ (import ./vm1/home.nix) ];
          };
        };
      }
    ];
  };

  vm2 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit version pkgs; };
    modules = [
      ./configuration.nix
      ./vm2

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit version pkgs; };
          users.user = {
            imports = [ (import ./home.nix) ] ++ [ (import ./vm2/home.nix) ];
          };
        };
      }
    ];
  };

  t15g1 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit version pkgs; };
    modules = [
      ./configuration.nix
      ./t15g1

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit version pkgs; };
          users.user = {
            imports = [ (import ./home.nix) ] ++ [ (import ./t15g1/home.nix) ];
          };
        };
      }
    ];
  };
}

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
        rev = "b510aca42621c867f3fe04fd1c9b620318228b3c";
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

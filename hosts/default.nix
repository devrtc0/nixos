{ nixpkgs, ... }:
let
  lib = nixpkgs.lib;
in
{
  vm = lib.nixosSystem {
    modules = [
      ./configuration.nix
      ./vm
    ];
  };
}

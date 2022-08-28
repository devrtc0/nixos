{ nixpkgs, ... }:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";

in
{
  vm = lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      ./vm
    ];
  };
}

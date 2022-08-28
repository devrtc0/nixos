{ nixpkgs, user, ... }:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";
in
{
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [
      ./configuration.nix
      ./vm
    ];
  };
}

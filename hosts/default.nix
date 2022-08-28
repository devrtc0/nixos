{ nixpkgs, ... }:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit pkgs; };
    modules = [
      ./configuration.nix
      ./vm
    ];
  };
}

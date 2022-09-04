{ nixpkgs, user, home-manager, version, ... }:
let
  system = "x86_64-linux";
  lib = nixpkgs.lib;
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user version; };
    modules = [
      ./configuration.nix
      ./vm

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user version; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./vm/home.nix) ];
        };
      }
    ];
  };
}

{ nixpkgs, user, home-manager, version, system, ... }:
let
  lib = nixpkgs.lib;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      hardware.enableAllFirmware = true;
    };
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
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user version; };
          users.${user} = {
            imports = [ (import ./home.nix) ] ++ [ (import ./vm/home.nix) ];
          };
        };
      }
    ];
  };
}

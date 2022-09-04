{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      user = "azat";
      version = "22.11";
    in
    {
      nixosConfigurations =
        import ./hosts {
          inherit nixpkgs user home-manager version;
        };
    };
}

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
      version = "23.05";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations =
        import ./hosts {
          inherit nixpkgs home-manager version system;
        };
    };
}

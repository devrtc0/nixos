{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my_overlays = { url = "github:devrtc0/nix-overlays"; flake = false; };
  };

  outputs = { self, nixpkgs, home-manager, my_overlays, ... }:
    let
      version = "22.11";
      system = "x86_64-linux";
    in
    {
      nixpkgs.overlays = [
        (import "${my_overlays}")
      ];
      nixosConfigurations =
        import ./hosts {
          inherit nixpkgs home-manager version system;
        };
    };
}

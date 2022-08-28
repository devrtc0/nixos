{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:devrtc0/nixpkgs/nixos-22.05";
  };

  outputs = { self, nixpkgs, ... }:
    let user = "azat";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit nixpkgs user;
        }
      );
    };
}

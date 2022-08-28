{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let user = "azat";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit nixpkgs;
        }
      );
    };
}

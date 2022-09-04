{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let user = "azat";
    in
    {
      nixosConfigurations =
        import ./hosts {
          inherit nixpkgs user;
        };
    };
}

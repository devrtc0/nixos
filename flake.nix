{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
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

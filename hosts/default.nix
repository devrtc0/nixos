{ nixpkgs, home-manager, version, system, ... }:
let
  lib = nixpkgs.lib;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      hardware.firmware = [
        "linux-firmware"
      ];
    };
    overlays = [
      (self: super: {
        yandex-browser-beta = super.yandex-browser.overrideAttrs (old: rec {
          version = "22.7.5.934-1";
          pname = old.pname;
          meta.knownVulnerabilities = [ ];
          src = super.fetchurl {
            url = "http://repo.yandex.ru/yandex-browser/deb/pool/main/y/${pname}-beta/${pname}-beta_${version}_amd64.deb";
            sha256 = "d5c97df71d72408d3c7dfae8420b0908f18cc92e4ebca44c6480a7ffe16349a5";
          };
          installPhase = ''
            cp $TMP/ya/{usr/share,opt} $out/ -R
            substituteInPlace $out/share/applications/yandex-browser-beta.desktop --replace /usr/ $out/
            ln -sf $out/opt/yandex/browser-beta/yandex_browser $out/bin/yandex-browser-beta
          '';
        });
      })
    ];
  };
in
{
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit version pkgs; };
    modules = [
      ./configuration.nix
      ./vm

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit version pkgs; };
          users.user = {
            imports = [ (import ./home.nix) ] ++ [ (import ./vm/home.nix) ];
          };
        };
      }
    ];
  };
}

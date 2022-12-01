{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "http://192.168.3.188:4444/"
  ];

  networking = {
    hostName = "vm";
  };
  environment = {
    systemPackages = with pkgs; [
        jq
        fd
        exa
        ripgrep
        rnix-lsp
        p7zip
        unrar
        zip
        unzip
        pbzip2
        pigz
        rust-analyzer
      ];
  };
}

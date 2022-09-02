{ pkgs, user, ... }:

{
  boot.kernelParams = [ "mitigations=off" ];
  nixpkgs.overlays = [
    (self: super: {
      yandex-browser = super.yandex-browser.overrideAttrs (old: rec {
        version = "22.7.1.828-1";
        pname = old.pname;
        meta.knownVulnerabilities = [ ];
        src = super.fetchurl {
          url = "http://repo.yandex.ru/yandex-browser/deb/pool/main/y/${pname}-beta/${pname}-beta_${version}_amd64.deb";
          sha256 = "11510b5f46a170b5da831c14870ab1e183afe65635cc7835258519ec0164c7d7";
        };
      });
    })
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ ];
  time = {
    timeZone = "Europe/Samara";
  };
  system = {
    stateVersion = "22.05";
  };
  environment = {
    systemPackages = with pkgs; [
      pciutils
      micro
      mc
      htop
      oath-toolkit
      keepassxc
      flameshot
      tdesktop
      lazygit
      yt-dlp
      mkvtoolnix
      jq
      fd
      exa
      ripgrep
      ldns
      rnix-lsp
      p7zip
      unrar
      zip
      unzip
      pbzip2
      pigz
      firefox
      chromium
      yandex-browser
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
        ];
      })
    ];
  };
  fonts.fonts = with pkgs; [
    hack-font
  ];
  users = {
    defaultUserShell = pkgs.fish;
    users = {
      ${user} = {
        isNormalUser = true;
        hashedPassword = "$6$r3DQjq.D2fz8rc5I$BtHOQnP/.lIcUJbcPyuRZH6ChQbfh.WEYgiX8ZqkF5RAuU/a5ebEZtuZ9tmbHdH9YOW/Gm6/fHFaQEvQRlk2R0";
        extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "disk" ];
      };
    };
  };
  systemd = {
    services = {
      NetworkManager-wait-online = {
        enable = false;
      };
    };
  };
  services = {
    fstrim = {
      enable = true;
    };
  };
  programs = {
    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "master";
        };
      };
    };
    gnupg = {
      agent = {
        enable = true;
      };
    };
    ssh = {
      startAgent = true;
    };
  };
}

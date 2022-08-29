{ pkgs, user, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      yandex-browser-beta = super.yandex-browser.overrideAttrs (old: {
        version = "22.7.1.828-1";
        meta.knownVulnerabilities = [ ];
        src = super.fetchurl {
          url = "https://repo.yandex.ru/yandex-browser/deb/pool/main/y/yandex-browser-beta/yandex-browser-beta_22.7.1.828-1_amd64.deb";
          sha256 = "11510b5f46a170b5da831c14870ab1e183afe65635cc7835258519ec0164c7d7";
        };
      });
    })
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
  ];
  time = {
    timeZone = "Europe/Samara";
  };
  system = {
    stateVersion = "22.05";
  };
  environment = {
    systemPackages = with pkgs; [
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
      git-crypt
      ldns
      rnix-lsp
      p7zip
      unrar
      zip
      unzip
      pbzip2
      pigz
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      hack-font
      exfat
      exfatprogs
      firefox
      chromium
      yandex-browser-beta
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
        ];
      })
    ];
  };
  users = {
    defaultUserShell = pkgs.fish;
    users.${user} = {
      isNormalUser = true;
      initialPassword = ".";
      extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "disk" ];
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

{ pkgs, user, version, ... }:

{
  boot = {
    tmpOnTmpfs = true;
    kernelParams = [ "mitigations=off" ];
  };
  nixpkgs.overlays = [
    (self: super: {
      yandex-browser-beta = super.yandex-browser.overrideAttrs (old: rec {
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
  time = {
    timeZone = "Europe/Samara";
  };
  system = {
    stateVersion = version;
  };
  environment = {
    variables = {
      EDITOR = "micro";
      VISUAL = "codium";
    };
    systemPackages = with pkgs; [
      pciutils
      micro
      mc
      htop
      oath-toolkit
      keepassxc
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
      yandex-browser-beta
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
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_TIME = "en_GB.UTF-8";
    };
  };
}

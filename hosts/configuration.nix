{ pkgs, version, ... }:

{
  boot = {
    tmpOnTmpfs = true;
    kernelParams = [ "mitigations=off" ];
  };
  time = {
    timeZone = "Europe/Samara";
  };
  system = {
    stateVersion = version;
  };
  environment = {
    shells = [ pkgs.fish ];
    variables = {
      EDITOR = "micro";
      VISUAL = "codium";
    };
    systemPackages = with pkgs;
      let codiumWithExtensions = vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
          serayuzgur.crates
          tamasfe.even-better-toml
          matklad.rust-analyzer
        ];
      };
      in
      [
        pciutils
        micro
        mc
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
        yandex-browser
        rust-analyzer
        codiumWithExtensions
      ];
  };
  fonts.fonts = with pkgs; [
    hack-font
  ];
  users = {
    users = {
      user = {
        isNormalUser = true;
        description = "User";
        shell = pkgs.fish;
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
    dnsmasq = {
      enable = true;
      servers = [
        "77.88.8.8"
        "77.88.8.1"
        "1.1.1.1"
        "8.8.8.8"
      ];
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
    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "ogfcmafjalglgifnmanfmnieipoejdcf" # umatrix
        "oboonakemofpalcgghocfoadofidjkkk" # keepassxc-browser
        "ponfpcnoihfmfllpaingbgckeeldkhle" # enhancer-for-youtube
        "npgcnondjocldhldegnakemclmfkngch" # обход-блокировок-рунета
      ];
    };
    htop = {
      enable = true;
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
  networking = {
    nameservers = [ "127.0.0.1" ];
    dhcpcd = {
      wait = "background";
      extraConfig = ''
        nohook resolv.conf
        noarp
      '';
    };
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };
}

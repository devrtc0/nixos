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
      user = {
        isNormalUser = true;
        description = "User";
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

{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "http://192.168.3.188:4444/"
  ];

  virtualisation.virtualbox.guest = {
    enable = true;
    x11 = true;
  };
  users.users.azat.extraGroups = [ "networkmanager" "vboxsf" ];
  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
        };
      };
      desktopManager = {
        plasma5 = {
          enable = true;
        };
        xterm = {
          enable = false;
        };
      };
      autoRepeatDelay = 300;
      autoRepeatInterval = 30;
      layout = "us,ru";
      xkbModel = "pc105";
      xkbOptions = "terminate:ctrl_alt_bksp,grp:win_space_toggle";
    };
    dnsmasq = {
      enable = true;
      settings = {
        servers = [
          "77.88.8.8"
          "77.88.8.1"
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
    };
  };
  programs = {
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
  networking = {
    hostName = "vm";
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
  environment = {
    variables = {
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
        ] ++ vscode-utils.extensionsFromVscodeMarketplace [
          {
            # https://marketplace.visualstudio.com/items?itemName=VisualStudioExptTeam.vscodeintellicode
            name = "vscodeintellicode";
            publisher = "VisualStudioExptTeam";
            version = "1.2.29";
            sha256 = "5a5fbe77b9823a380beef99554028f410816452165a8be2bcbbbf4c286f53b25";
          }
        ];
      };
      in
      [
        oath-toolkit
        keepassxc
        tdesktop
        gitui
        yt-dlp
        mkvtoolnix
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
        firefox
        chromium
        rust-analyzer
        codiumWithExtensions
        kde-gtk-config
      ];
    plasma5 = {
      excludePackages = with pkgs; [
        plasma5Packages.elisa
      ];
    };
  };
  systemd = {
    services = {
      NetworkManager-wait-online = {
        enable = false;
      };
    };
  };
  fonts.fonts = with pkgs; [
    hack-font
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}

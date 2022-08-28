{ pkgs, user, ... }:
let yandex-browser-beta = pkgs.yandex-browser.overrideAttrs (old: { version = "22.7.1.828-1"; meta.knownVulnerabilities = []; });
in
{
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

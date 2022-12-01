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
    };
    systemPackages = with pkgs; [
      pciutils
      micro
      mc
      ldns
    ];
  };
  users = {
    users = {
      azat = {
        isNormalUser = true;
        description = "Azat";
        shell = pkgs.fish;
        hashedPassword = "$6$r3DQjq.D2fz8rc5I$BtHOQnP/.lIcUJbcPyuRZH6ChQbfh.WEYgiX8ZqkF5RAuU/a5ebEZtuZ9tmbHdH9YOW/Gm6/fHFaQEvQRlk2R0";
        extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "disk" ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKPBlmW9r5Y8Zj8cTxECLO9HEY+USByhVDxdPxq++oy2 id_ed25519"
        ];
      };
    };
  };
  services = {
    fstrim = {
      enable = true;
    };
    openssh = {
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
}

{ pkgs, user, ... }: {
  nixpkgs.config.allowUnfree = true;
  time = {
    timeZone = "Europe/Samara";
  };
  system = {
    stateVersion = "22.11";
  };
  environment = {
    systemPackages = with pkgs; [
      micro
      mc
      htop
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

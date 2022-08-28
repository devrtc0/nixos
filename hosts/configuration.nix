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
      git
      micro
      mc
      htop
    ];
  };
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" ];
  };
  users.defaultUserShell = pkgs.fish;
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
  boot.blacklistedKernelModules = [ "uvcvideo" ];
}

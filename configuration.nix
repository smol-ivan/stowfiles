{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.kernelParams = [
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "nvidia_drm.modeset=1"
    "nvidia_drm.fbdev=1"
  ];

  networking.hostName = "nixos-smol"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Mexico_City";

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
    ];
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  xdg.portal = {
    enable = true;
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  programs.nix-ld.enable = true;

  hardware.uinput.enable = true;

  services.kanata = {
    enable = true;
    keyboards = {
      "myKeyboard" = {
        devices = [ "/dev/input/by-path/pci-0000:09:00.4-usbv2-0:1:1.0-event-kbd" ];
        configFile = ./dotfiles/kanata/layout.kbd;
      };

    };
  };

  services.displayManager.noctalia-greeter = {
    enable = true;
    passwordlessSyncUsers = [ "chattini" ];
    settings = {
      cursor.size = 24;
      keyboard.layout = "us";
      keyboard.variant = "colemak_dh_wide";
      session = {
        default = "Hyprland (uwsm-managed)";
      };
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = { };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;

  users.users.chattini = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "uinput"
      "docker"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    alacritty
    neovim
    git
    wl-clipboard
    fastfetch
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    maple-mono.NF
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persitenced"
      "github-copilot-cli"
      "antigravity-cli"
    ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.kernelSuspendNotifier = true;

  system.stateVersion = "26.05";

}

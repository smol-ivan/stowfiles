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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 2;

  networking.hostName = "nixos-smol"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Mexico_City";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.getty.autologinUser = "chattini";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.chattini = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    alacritty
    noctalia
    neovim
    git
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";

}

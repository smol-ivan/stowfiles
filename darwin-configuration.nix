{ pkgs, ... }:

{
  # Arquitectura y plataforma
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Usuario principal para las configuraciones de sistema de macOS
  system.primaryUser = "cherry";

  users.users.cherry = {
    name = "cherry";
    home = "/Users/cherry";
  };

  # Configuración declarativa de preferencias de macOS
  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv"; # Vista de lista
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark"; # Modo oscuro
      "com.apple.sound.beep.feedback" = 0;
    };
  };

  # Gestión declarativa de aplicaciones GUI con Homebrew Cask
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
    };
    casks = [
      "betterdisplay"
      "iina"
      "font-maple-mono-nf"
    ];
  };

  programs.zsh.enable = true;

  # Estado de configuración de nix-darwin
  system.stateVersion = 5;
}

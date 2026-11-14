{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/bone/nixosfiles/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    alacritty = "alacritty";
  };
in
{
  imports = [
    ./nvimnvf.nix
    ./zsh.nix
    ./tmux.nix
  ];

  home.username = "cherry";
  home.homeDirectory = "/Users/cherry";
  home.stateVersion = "24.11";

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  programs.git = {
    enable = true;
    settings.user = {
      name = "Ivan Gordillo";
      email = "gordillosolis@icloud.com";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Permite caching rápido con Flakes
  };

  # CLI Tools gestionadas puramente por Nix
  home.packages = with pkgs; [
    # Terminal & utilidades
    alacritty
    tmux-sessionizer
    lazygit
    ripgrep
    # fd
    # eza
    # fzf
    tree
    # yt-dlp
    # ffmpeg
    mpv
  ];
}

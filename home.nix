{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/bone/nixosfiles/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    alacritty = "alacritty";
    hypr = "hypr";
    noctalia = "noctalia";
    kanata = "kanata";
  };
in
{

  imports = [
    ./nvimnvf.nix
    ./zsh.nix
    ./tmux.nix
  ];

  home.username = "chattini";
  home.homeDirectory = "/home/chattini";
  home.stateVersion = "26.05";

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "Ivan Gordillo";
      email = "gordillosolis@icloud.com";
    };
  };

  programs.antigravity-cli.enable = true;
  programs.github-copilot-cli.enable = true;

  home.packages = with pkgs; [
    tmux-sessionizer
    lazygit
    pavucontrol
    zathura
  ];
}

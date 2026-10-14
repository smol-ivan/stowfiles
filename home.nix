{ config, pkgs, ... }:

{

  imports = [
    ./nvimnvf.nix
  ];

  home.username = "chattini";
  home.homeDirectory = "/home/chattini";
  home.stateVersion = "26.05";

  programs.zsh = {
    profileExtra = ''
        if [ "$(tty)" = "/dev/tty1" ]; then
          exec Hyprland
        fi
    '';
  };

  home.file.".config/alacritty".source = ./dotfiles/alacritty;
  home.file.".config/hypr".source = ./dotfiles/hypr;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}

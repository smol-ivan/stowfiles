{ config, pkgs, ... }:

{

  imports = [
    ./nvimnvf.nix
  ];

  home.username = "chattini";
  home.homeDirectory = "/home/chattini";
  home.stateVersion = "26.05";

  programs.zsh = {
    enable = true;
    shellAliases = {
      smol = "echo im using nixos";
    };
    profileExtra = ''
      	    if [ "$XDG_VTNR" = 1 ]; then
      		exec hyprland
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

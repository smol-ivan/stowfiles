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

  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/hypr".source = ./config/hypr;
  home.file.".zshrc".source = ./config/zshell/.zshrc;
  home.file.".zsh".source = ./config/zshell/.zsh;

  progams.ssh = {
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

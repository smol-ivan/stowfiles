{ pkgs, ... }:

{
  programs.starship.enable = true;
  programs.fzf.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

    profileExtra = pkgs.lib.mkIf pkgs.stdenv.hostPlatform.isLinux ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec hyprland
      fi
    '';

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    shellAliases = {
      drs = "sudo darwin-rebuild switch --flake ~/bone/nixosfiles#MacBook-Air-de-Ivan";
    };

    shellGlobalAliases = {
      nrs = "nixos-rebuild switch --flake ~/bone/nixosfiles#nixos-smol";
    };
  };
}

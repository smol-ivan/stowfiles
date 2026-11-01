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

    initExtra = ''
      # Integración con Homebrew en macOS
      if [ -x "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      # Docker Desktop CLI (si existe)
      if [ -d "$HOME/.docker/bin" ]; then
        export PATH="$PATH:$HOME/.docker/bin"
      fi

      # Antigravity CLI / Local bin
      if [ -d "$HOME/.local/bin" ]; then
        export PATH="$HOME/.local/bin:$PATH"
      fi

      # pnpm
      if [ -d "$HOME/Library/pnpm" ]; then
        export PNPM_HOME="$HOME/Library/pnpm"
        export PATH="$PNPM_HOME:$PATH"
      fi
    '';

    shellAliases = {
      drs = "darwin-rebuild switch --flake ~/bone/nixosfiles#MacBook-Air-de-Ivan";
      hms = "darwin-rebuild switch --flake ~/bone/nixosfiles#MacBook-Air-de-Ivan";
    };

    shellGlobalAliases = {
      nrs = "nixos-rebuild switch --flake ~/bone/nixosfiles#nixos-smol";
    };
  };

}

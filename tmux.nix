{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # Tecla prefix (C-x)
    shortcut = "x";

    # Opciones que Home Manager abstrae directamente
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;

    # Plugins gestionados directamente por Nix
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      resurrect
    ];

    # Configuración restante en sintaxis nativa de Tmux
    extraConfig = ''
      set -g status-keys emacs

      # Mapeos de selección vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # nvim-tpipeline y barra de estado
      set -g focus-events on
      set -g status-style bg=default
      set -g status-left-length 99
      set -g status-right-length 99
      set -g status-justify centre
      set-option -g status-position top
      set -g status-right ""

      # Renumerar ventanas e índice de paneles
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Keybindings personalizados
      bind r source-file ~/.tmux.conf \; display-message "config reloaded"
      bind-key -r z run-shell "tmux new-window 'nohup zathura $(fzf)'"
      bind-key -r f run-shell "tmux neww tmux_sessionizer"
    '';
  };
}

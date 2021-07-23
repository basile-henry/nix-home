{ config, lib, pkgs, ... }:

{
  # Ensure locale is working well with tmux
  home.sessionVariables.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 30000;
    escapeTime = 0;
    extraConfig = ''
      set -g mouse on
      set-option -sa terminal-overrides ',*:RGB'

      # For multi-user edit
      set -g window-size smallest

      # Disable copy on mouse release
      unbind -T copy-mode-vi MouseDragEnd1Pane

      # Make split-window stay in the current directory
      bind % split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      # Vim-like pane movement
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      # Vim-like pane resizing
      bind -r C-h resize-pane -L
      bind -r C-j resize-pane -D
      bind -r C-k resize-pane -U
      bind -r C-l resize-pane -R
      '';

    # Makes it difficult to share tmux session otherwise
    secureSocket = false;

    plugins = with pkgs; [
      { plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          '';
      }
      { plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
          '';
      }
    ];
  };
}

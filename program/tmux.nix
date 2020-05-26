{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 10000;
    escapeTime = 0;
    extraConfig = ''
      set -g mouse on
      set-option -sa terminal-overrides ',*:RGB'
      '';

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

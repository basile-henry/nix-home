{ config, lib, pkgs, ... }:

{
  imports = [
    ./program/tmux.nix
    ./program/vim.nix
  ];

  home.packages = with pkgs; [
    exa
    fd
    ripgrep
    htop
    mosh
    jq
    lm_sensors
    vnstat

    # Dev
    gitAndTools.hub
    gitAndTools.gh
    gitAndTools.git-secret
    watchexec
    miniserve
    exercism
    gcc
    cachix

    # Shell
    shellcheck

    # Nix
    nix-index

    # Rust
    rustup
    cargo-watch
    cargo-edit

    # Haskell
    ghc
    ghcid
    cabal-install
    stylish-haskell

    # Elm
    elmPackages.elm
    elmPackages.elm-analyse
    elmPackages.elm-format

    # Dhall
    dhall
    dhall-lsp-server
  ];

  programs.bat = {
    enable = true;
    config.theme = "base16";
  };

  # Not with the packages, so that it also provides bash integration
  programs.fzf.enable = true;

  programs.bash = {
    enable = true;

    historyIgnore = [ "ls" "cd" ];
    historyControl = [ "erasedups" "ignorespace" ];

    shellAliases = {
      ns = "nix-shell";
      nb = "nix-build";

      hme = "(cd $HOME/.config/nixpkgs && vim .)";
      hms = "home-manager switch";

      ghcid = "ghcid --reverse-errors --no-height-limit --clear";

      tombo = "mosh --predict=always -a tombo.myrtle";
    };

    initExtra = ''
      # Fix nix path for multi-user nix Ubuntu setups
      export NIX_PATH=/home/basile/.nix-defexpr/channels:$NIX_PATH
      export PATH=/home/basile/.cargo/bin:$PATH

      # For bash autocomplete
      export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
      source /etc/profile.d/bash_completion.sh

      BASE16_SHELL="${pkgs.base16-shell}"
      [ -n "$PS1" ] && \
          [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
              eval "$("$BASE16_SHELL/profile_helper.sh")"

      new-workspace() {
        name="$1"
        path="$(git rev-parse --absolute-git-dir)/../../$name"
        commit="''${2:--}"

        git worktree add -b "$name" "$path" "$commit"
        tmux new-window -c "$path" -n "$name"
      }
      '';
  };

  programs.starship = {
    enable = true;

    settings = {
      character = {
        symbol = "➜";
        error_symbol = "✗";
        use_symbol_for_status = true;
      };
      cmd_duration.show_milliseconds = true;
      username.disabled = true;
      package.disabled = true;
      aws.disabled = true;
    };
  };

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;

  services.lorri.enable = true;

  programs.git = {
    enable = true;
    userName = "Basile Henry";
    userEmail = "bjm.henry@gmail.com";

    aliases = {
      s = "status";
      c = "commit";
      d = "diff";
      f = "fetch";
      co = "checkout";
      r = "rebase";
      root = "rev-parse --show-toplevel";
      # Rebase with pre-commit check at each commit
      rc = "rebase -x 'git reset --soft HEAD~1 && git commit -C HEAD@{1}'";

      lol = "log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";

      w = "worktree";
      wl = "worktree list";
      wa = "worktree add";
    };

    extraConfig = {
      merge.conflictstyle = "diff3";
      core.editor = "vim";
      pull.rebase = "true";
    };
  };

  programs.git.lfs.enable = true;
}

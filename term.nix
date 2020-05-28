{ config, lib, pkgs, ... }:

let unstable = import <nixpkgs-unstable> {};
in
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
    unstable.rust-analyzer

    # Nix
    nix-index

    # Rust
    rustup
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
    };

    profileExtra = ''
      # Fix nix path for multi-user nix Ubuntu setups
      export NIX_PATH=/home/basile/.nix-defexpr/channels:$NIX_PATH

      # For bash autocomplete
      export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS

      BASE16_SHELL="${pkgs.base16-shell}"
      [ -n "$PS1" ] && \
          [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
              eval "$("$BASE16_SHELL/profile_helper.sh")"
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
      nix_shell.use_name = true;
      package.disabled = true;
      aws.disabled = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Basile Henry";
    userEmail = "bjm.henry@gmail.com";

    aliases = {
      s = "status";
      co = "checkout";
      lol = "log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
    };

    extraConfig = {
      merge.conflictstyle = "diff3";
    };
  };

  programs.git.lfs.enable = true;
}

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
    bat
    fd
    fzf
    htop
    mosh
    starship
    unstable.rust-analyzer

    # Rust
    rustup
  ];

  programs.bash = {
    enable = true;

    sessionVariables = {
      EDITOR = "nvim";
      BAT_THEME = "base16";
    };

    shellAliases = {
      ns = "nix-shell";
      nb = "nix-build";

      hme = "(cd $HOME/.config/nixpkgs && vim .)";
      hms = "home-manager switch";

      gst = "git status";
      gco = "git checkout";
    };

    profileExtra = ''
      eval "$(starship init bash)"

      BASE16_SHELL="${pkgs.base16-shell}"
      [ -n "$PS1" ] && \
          [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
              eval "$("$BASE16_SHELL/profile_helper.sh")"
      '';
  };

  programs.git = {
    enable = true;
    userName = "Basile Henry";
    userEmail = "bjm.henry@gmail.com";
  };
}

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
  programs.starship.enable = true;

  programs.bash = {
    enable = true;
    sessionVariables.EDITOR = "nvim";

    shellAliases = {
      ns = "nix-shell";
      nb = "nix-build";

      hme = "(cd $HOME/.config/nixpkgs && vim .)";
      hms = "home-manager switch";
    };

    profileExtra = ''
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

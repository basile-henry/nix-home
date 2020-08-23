{ config, pkgs, ... }:

let unstable = import <nixpkgs-unstable> {};
in
{
  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    unstable.rust-analyzer

    # For CoC
    unstable.nodejs
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfig = ''
      set nocompatible
      set mouse=a
      set number
      set encoding=utf-8
      set termguicolors
      set spell spelllang=en_gb
      set hidden

      set undofile
      set undodir=~/.config/nvim/undodir
      set history=1000

      set expandtab
      set autoindent
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2

      set list!
      set list listchars=tab:»·,trail:·

      " Base16 colour scheme
      if !empty($REMOTE_THEME)
        colorscheme $REMOTE_THEME
      elseif filereadable(expand("~/.vimrc_background"))
        source ~/.vimrc_background
      endif

      let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }

      let mapleader=" "

      " fzf
      noremap <C-P> :GFiles<CR>

      " NERDCommenter
      let NERDSpaceDelims=1
      let NERDDefaultAlign='left'

      " NERDTree
      noremap <Leader>n :NERDTreeToggleVCS<CR>
      '';

    plugins = with pkgs.vimPlugins; [
      # Vim
      base16-vim
      lightline-vim
      fzf-vim

      nerdcommenter
      nerdtree
      nerdtree-git-plugin

      syntastic

      # Language Server
      unstable.vimPlugins.coc-nvim
      unstable.vimPlugins.coc-rust-analyzer
      unstable.vimPlugins.coc-fzf

      # Config formats
      vim-json
      vim-toml

      # Elm
      vim-elm-syntax

      # Git
      gitgutter
      fugitive

      # Haskell
      # haskell-vim

      # Nix
      vim-nix

      # Python
      jedi-vim
    ];

    # Disable python 2 provider
    withPython = false;
    withRuby = false;
  };
}

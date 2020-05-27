{ config, pkgs, ... }:

{
  home.sessionVariables.EDITOR = "nvim";

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

      set undofile
      set undodir=~/.config/nvim/undodir
      set history=1000

      set expandtab
      set autoindent
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2

      let g:deoplete#enable_at_startup = 1

      " Base16 colour scheme
      if filereadable(expand("~/.vimrc_background"))
        " let base16colorspace=256
        source ~/.vimrc_background
      endif

      let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }

      let mapleader=" "

      " fzf
      map <C-P> :GFiles<CR>

      " NERDTree
      map <Leader>n :NERDTreeToggleVCS<CR>

      " LSP
      let g:LanguageClient_serverCommands = {
        \ 'rust': ['rust-analyzer'],
        \ }

      '';

    plugins = with pkgs.vimPlugins; [
      # Vim
      base16-vim
      lightline-vim
      fzf-vim
      deoplete-nvim

      nerdcommenter
      nerdtree
      nerdtree-git-plugin

      # Language Server
      LanguageClient-neovim

      # Git
      gitgutter
      fugitive

      # Nix
      vim-nix
    ];
  };
}

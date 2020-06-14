{ config, pkgs, ... }:

let unstable = import <nixpkgs-unstable> {};
in
{
  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    elmPackages.elm-language-server
    python3Packages.python-language-server
    unstable.rust-analyzer
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

      let g:deoplete#enable_at_startup = 1

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

      " NERDTree
      noremap <Leader>n :NERDTreeToggleVCS<CR>

      " LSP
      let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
      nnoremap <Leader>m :call LanguageClient_contextMenu()<CR>

      let g:LanguageClient_serverCommands = {
        \ 'elm': ['elm-language-server'],
        \ 'python': ['pyls'],
        \ 'rust': ['rust-analyzer'],
        \ }
      let g:LanguageClient_rootMarkers = {
        \ 'elm': ['elm.json'],
        \ }

      " LSP format on save
      execute 'autocmd FileType rust,elm autocmd BufWritePre <buffer> call LanguageClient#textDocument_formatting_sync()'
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

      # Elm
      vim-elm-syntax

      # Git
      gitgutter
      fugitive

      # Haskell
      haskell-vim

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

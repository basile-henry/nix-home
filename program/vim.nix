{ config, pkgs, ... }:

let unstable = import <nixpkgs-unstable> {};
in
{
  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    unstable.rust-analyzer
    unstable.ccls

    # For CoC
    unstable.nodejs

    unstable.rnix-lsp
  ];

  xdg.configFile."nvim/coc-settings.json".text = builtins.readFile ./coc-settings.json;

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

      set inccommand=split

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
      noremap <Leader>n :NERDTreeToggle<CR>

      " CoC
      " Some servers have issues with backup files, see #649.
      set nobackup
      set nowritebackup

      " Give more space for displaying messages.
      set cmdheight=2

      " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
      " delays and poor user experience.
      set updatetime=300

      " Don't pass messages to |ins-completion-menu|.
      set shortmess+=c

      " Always show the signcolumn, otherwise it would shift the text each time
      " diagnostics appear/become resolved.
      if has("patch-8.1.1564")
        " Recently vim can merge signcolumn and number column into one
        set signcolumn=number
      else
        set signcolumn=yes
      endif

      " Use tab for trigger completion with characters ahead and navigate.
      " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
      " other plugin before putting this into your config.
      inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      " Make <CR> auto-select the first completion item and notify coc.nvim to
      " format on enter, <cr> could be remapped by other vim plugin
      inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

      " Use `[g` and `]g` to navigate diagnostics
      " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)

      " GoTo code navigation.
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      " Use K to show documentation in preview window.
      nnoremap <silent> K :call <SID>show_documentation()<CR>

      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
          call CocActionAsync('doHover')
        else
          execute '!' . &keywordprg . " " . expand('<cword>')
        endif
      endfunction

      " Highlight the symbol and its references when holding the cursor.
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " Symbol renaming.
      nmap <leader>rn <Plug>(coc-rename)

      " Formatting selected code.
      xmap <leader>f  <Plug>(coc-format-selected)
      nmap <leader>f  <Plug>(coc-format-selected)
      '';

    plugins = with pkgs.vimPlugins; [
      # Vim
      base16-vim
      lightline-vim
      fzf-vim

      nerdcommenter
      nerdtree
      unstable.vimPlugins.nerdtree-git-plugin

      syntastic

      # Language Server
      unstable.vimPlugins.coc-nvim
      unstable.vimPlugins.coc-rust-analyzer
      unstable.vimPlugins.coc-fzf
      unstable.vimPlugins.coc-json
      unstable.vimPlugins.coc-spell-checker

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

    withRuby = false;
  };
}

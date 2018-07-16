""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basics
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set encoding=utf-8
set ruler
set laststatus=2
set number
set hidden
set shell=/bin/bash

" Editing, Display, and Autocompletion
set autoindent
set autoread
set backspace=indent,eol,start
set display+=lastline
set foldmethod=syntax
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set nofoldenable
set nowrap
set nrformats-=octal
set scrolloff=1
set sidescrolloff=5
set wildmenu
set wildmode=longest:full
runtime! macros/matchit.vim
" Improve CTRL-U in insert mode.
" https://github.com/tpope/vim-sensible/issues/28
inoremap <C-U> <C-G>u<C-U>

" Use soft tabs.
set expandtab
set smarttab
" Set tab size to 2.
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Search
set incsearch
" Use case-insensitive search, except when the input has capital letters.
set ignorecase
set smartcase
" Clear current-search highlighting by hitting <CR> in normal mode.
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Customize viminfo and directories.
set viminfo='100,f1,<50,s10,h,n~/.config/vim/viminfo
set backupdir=~/.config/vim/.backup//
set directory=~/.config/vim/.swap//

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic Whitespace Trimming and Formatting (for select filetypes)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists("formatting_autocommands_loaded")
  let formatting_autocommands_loaded = 1

  " Trim trailing whitespace before saving code files.
  autocmd BufWritePre *.rb     :%s/\s\+$//e
  autocmd BufWritePre *.rake   :%s/\s\+$//e
  autocmd BufWritePre *.sass   :%s/\s\+$//e
endif

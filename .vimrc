"
" Basics
"
set nocompatible
set encoding=utf-8
set ruler
set number
" Use soft tabs.
set expandtab
set smarttab
" Set tab size to 2.
set shiftwidth=2
set softtabstop=2
set tabstop=2
" Customize viminfo.
" Store it and other vim-specific files in the ~/.vim directory.
set viminfo='100,f1,<50,s10,h,n~/.vim/viminfo
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swap//

"
" NeoBundle and Other Plugins
"
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" Other Bundles
NeoBundle 'tpope/vim-sensible'
" Close NeoBundle block.
call neobundle#end()
filetype plugin indent on
" Prompt to install uninstalled bundles.
NeoBundleCheck

"
" Syntax Highlighting
"
syntax enable


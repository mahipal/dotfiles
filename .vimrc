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
" Let NeoBundle manage NeoBundle.
NeoBundleFetch 'Shougo/neobundle.vim'
" Other Bundles
NeoBundle 'tpope/vim-sensible'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', { 'build' : { 'mac' : 'make -f make_mac.mak', }, }
NeoBundle 'kchmck/vim-coffee-script'
" Close NeoBundle block.
call neobundle#end()
filetype plugin indent on
" Prompt to install uninstalled bundles.
NeoBundleCheck

"
" Syntax Highlighting
"
syntax enable

"
" Set up Unite.
"
let g:unite_source_history_yank_enable = 1
let g:unite_source_rec_min_cache_files = 0
let g:unite_source_rec_max_cache_files = 0

call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <C-P> :<C-u>execute 'Unite -no-split -start-insert' 'file_rec/git:--others:--exclude-standard:--cached:--full-name:'.unite#util#path2project_directory(getcwd())<CR>


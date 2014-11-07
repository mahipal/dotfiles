"
" Basics
"
set nocompatible
set encoding=utf-8
set ruler
set number
set nowrap
set hidden
set wildmode=longest,full
" Use soft tabs.
set expandtab
set smarttab
" Set tab size to 2.
set shiftwidth=2
set softtabstop=2
set tabstop=2
" Use case-insensitive search, except when the input has capital letters.
set ignorecase
set smartcase
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
" Generally Useful Things
NeoBundle 'tpope/vim-sensible'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc', { 'build' : { 'mac' : 'make -f make_mac.mak', 'unix' : 'make -f make_unix.mak', }, }
" NeoBundle 'tpope/vim-commentary'
" Colors, Status Line, Etc.
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
" Plugins Specific to File-Types
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'digitaltoad/vim-jade'

if v:version > 703 && has("lua")
  NeoBundle 'Shougo/neocomplete.vim'
end

call neobundle#end()
filetype plugin indent on
" Prompt to install uninstalled bundles.
NeoBundleCheck

"
" Syntax Highlighting
"
syntax enable

let g:solarized_termcolors = 256
set background=dark
colorscheme solarized

"
" Autocommands
"

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  " Trim trailing whitespace before saving code files.
  autocmd BufWritePre *.rb     :%s/\s\+$//e
  autocmd BufWritePre *.coffee :%s/\s\+$//e
  autocmd BufWritePre *.rake   :%s/\s\+$//e

  " Set filetypes for exotic extensions to get syntax highlighting.
  autocmd BufNewFile,BufRead *.hql set filetype=sql
  autocmd BufNewFile,BufRead *.hql.erb set filetype=eruby.sql
endif
"
" Set up Unite.
"
let g:unite_source_history_yank_enable = 1
let g:unite_source_rec_min_cache_files = 0
let g:unite_source_rec_max_cache_files = 0

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-P> :<C-u>execute 'Unite -no-split -start-insert' 'file_rec/git:--others:--exclude-standard:--cached:--full-name:'.unite#util#path2project_directory(getcwd())<CR>
nnoremap <Leader>p :<C-u>Unite -no-split -start-insert -buffer-name=yank history/yank<CR>

"
" Set up NeoComplete.
"
if v:version <= 703 || !has("lua")
  finish
end

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif


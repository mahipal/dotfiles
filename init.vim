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
" The status line will show the mode.
set noshowmode
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

" Performance Improvements
set lazyredraw
set nocursorline
set ttyfast
let g:matchparen_timeout = 10
let g:matchparen_insert_timeout = 10

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
set viminfo='100,f1,<50,s10,h,n~/.config/nvim/viminfo
set backupdir=~/.config/nvim/.backup//
set directory=~/.config/nvim/.swap//

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let dein_installation_directory = '~/.config/nvim/dein'
let dein_source_directory = dein_installation_directory . '/repos/github.com/Shougo/dein.vim'

let &runtimepath = &runtimepath . ',' . dein_source_directory

if dein#load_state(dein_installation_directory)
  call dein#begin(dein_installation_directory)

  " Basics
  call dein#add(dein_source_directory) " Let dein manage dein.
  call dein#add('Shougo/denite.nvim')

  " Completions and Linting
  call dein#add('autozimu/LanguageClient-neovim', { 'rev': 'next', 'build': 'bash install.sh' })
  call dein#add('Shougo/deoplete.nvim')
  " call dein#add('Shougo/echodoc.vim')
  call dein#add('Shougo/neco-syntax') " syntax source for deoplete
  call dein#add('uplus/deoplete-solargraph')
  call dein#add('w0rp/ale')

  " Visual
  call dein#add('altercation/vim-colors-solarized') " color scheme
  call dein#add('itchyny/lightline.vim')

  " Language-Specific (alphabetical by package-identifier)
  call dein#add('chr4/nginx.vim') " nginx configs
  call dein#add('fatih/vim-go') " Golang
  call dein#add('HerringtonDarkholme/yats.vim') " TypeScript syntax file
  call dein#add('mxw/vim-jsx') " JSX highlighter (depends on underlying JS highlighter)
  call dein#add('pangloss/vim-javascript') " JS highlighter ('official' dependency of vim-jsx)
  call dein#add('reasonml-editor/vim-reason-plus') " ReasonML syntax highlighting
  call dein#add('slim-template/vim-slim') " Slim syntax highlighting
  call dein#add('tpope/vim-rails')

  call dein#end()
  call dein#save_state()
endif

" On startup, install not-installed plugins.
if dein#check_install()
  call dein#install()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:solarized_termcolors=256
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'custom-lineinfo' ],
      \              [ 'custom-fileinfo' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'custom-lineinfo' ],
      \              [ 'custom-fileinfo' ] ],
      \ },
      \ 'component': {
      \   'custom-lineinfo': ' %3p%% ┃ %4l/%L :%3c',
      \ },
      \ 'component_function': {
      \   'custom-fileinfo': 'LightlineFileInfo',
      \   'readonly': 'LightlineReadonly',
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': [ ],
      \ },
\ }

function! LightlineReadonly()
  return &readonly ? '∄' : ''
endfunction

function! LightlineFileInfo()
  let displayFiletype = &filetype !=# '' ? &filetype : 'no ft'
  return ' ' . displayFiletype . ' ┃  ' . &fileencoding . '[' . &fileformat . '] '
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:LanguageClient_serverCommands = {
      \ 'reason': ['/Users/paul/code/reason-language-server/reason-language-server.exe'],
      \ }
let g:LanguageClient_hoverPreview = 'Never'

" Speed Improvements for Deoplete
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()

" Autocomplete and cycle from top-to-bottom of suggestions using <Tab>.
inoremap <expr><TAB> pumvisible() ? "\<c-n>" : "\<TAB>"

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" additional useful key-bindings
inoremap <expr><C-g>       deoplete#refresh()
inoremap <expr><C-e>       deoplete#cancel_popup()
inoremap <silent><expr><C-l>       deoplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

call deoplete#custom#option('camel_case', v:true)
call deoplete#custom#option('auto_complete_delay', 0)
call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#option('min_pattern_length', 1)

call deoplete#custom#option('sources', {
      \ '_': ['tag', 'buffer', 'file', 'LanguageClient', 'syntax'],
      \ 'ruby': ['tag', 'solargraph', 'buffer', 'file', 'syntax'],
      \ 'eruby': ['tag', 'solargraph', 'buffer', 'file', 'syntax'],
\})

" Disable the preview window for completions.
set completeopt-=preview

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic Whitespace Trimming and Formatting (for select filetypes)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'ruby': ['rubocop'],
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Denite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Ctrl+P to pull up a list of all the files in the Git repo.
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '--cached', '--others', '--exclude-standard', '--full-name'])
nnoremap <C-P> :<C-u>execute 'DeniteProjectDir' 'file_rec/git'<CR>
" Use up and down arrow keys to navigate the list.
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>',     'noremap')
call denite#custom#map('insert', '<Up>',   '<denite:move_to_previous_line>', 'noremap')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

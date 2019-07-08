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

call plug#begin('~/.config/nvim/plugged')

" Visual Improvements
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'

" Language Specific (alphabetical by package-identifier)
" These should be loaded 'on demand' rather than at startup.
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'chr4/nginx.vim', { 'for': 'nginx' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'mxw/vim-jsx', { 'for': 'jsx' } " depends on vim-javascript
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'reasonml-editor/vim-reason-plus', { 'for': 'reasonml' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Completions
" core plugin first, then alphabetical by package-identifier
Plug 'neoclide/coc.nvim',       { 'do': 'yarn install --frozen-lockfile' }
Plug 'iamcco/coc-vimlsp',       { 'do': 'yarn install --frozen-lockfile', 'for': 'vim' }
Plug 'neoclide/coc-css',        { 'do': 'yarn install --frozen-lockfile', 'for': 'css' }
Plug 'neoclide/coc-html',       { 'do': 'yarn install --frozen-lockfile', 'for': 'html' }
Plug 'neoclide/coc-json',       { 'do': 'yarn install --frozen-lockfile', 'for': 'json' }
Plug 'neoclide/coc-python',     { 'do': 'yarn install --frozen-lockfile', 'for': 'python' }
Plug 'neoclide/coc-solargraph', { 'do': 'yarn install --frozen-lockfile', 'for': 'ruby' }
Plug 'neoclide/coc-yaml',       { 'do': 'yarn install --frozen-lockfile', 'for': 'yaml' }

" Linting
Plug 'w0rp/ale'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:solarized_termcolors=256
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO:
"
"   - Show the full path to the file (maybe with abbreviated directory names),
"     rather than just the name of the file.
"
"   - Show unsaved files in orange with the [+] next to them, like the old
"     status-line plugin -- currently sometimes it is easy to not notice an
"     unsaved file.
"
"   - Set colors the way the old status-line plugin had them, with some more
"     color on the right side.

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'custom-filepath', 'modified' ] ],
      \   'right': [ [ 'custom-lineinfo' ],
      \              [ 'custom-fileinfo' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'readonly', 'custom-filepath', 'modified' ] ],
      \   'right': [ [ 'custom-lineinfo' ],
      \              [ 'custom-fileinfo' ] ],
      \ },
      \ 'component': {
      \   'custom-lineinfo': ' %3p%% ┃ %4l/%L :%3c',
      \   'custom-filepath': '%f',
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
" fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use CTRL+P to open fuzzy-finder for all files in this repo
nnoremap <C-P> :call fzf#run(fzf#wrap({ 'source': 'git ls-files --cached --others --exclude-standard --full-name', 'sink': 'e' }))<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set signcolumn=yes

" Autocomplete and cycle from top-to-bottom of suggestions using <Tab>.
inoremap <expr><TAB> pumvisible() ? "\<c-n>" : "\<TAB>"

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"""""""""""""""""""""""""

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup cocgroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" " Disable the preview window for completions.
" set completeopt-=preview

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'ruby': ['rubocop'],
\}

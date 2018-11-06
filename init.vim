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
  call dein#add(dein_installation_directory)

  " Basics
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')

  " Visual
  call dein#add('altercation/vim-colors-solarized') " color scheme
  call dein#add('vim-airline/vim-airline') " status line
  call dein#add('vim-airline/vim-airline-themes') " status line colors

  " Language-Specific (alphabetical by package-identifier)
  call dein#add('chr4/nginx.vim') " nginx configs
  call dein#add('fatih/vim-go') " Golang
  call dein#add('fishbullet/deoplete-ruby') " simple Ruby
  call dein#add('HerringtonDarkholme/yats.vim') " TypeScript syntax file
  call dein#add('mhartington/nvim-typescript', { 'build': './install.sh' }) " TypeScript
  call dein#add('mxw/vim-jsx') " JSX highlighter (depends on underlying JS highlighter)
  call dein#add('pangloss/vim-javascript') " JS highlighter ('official' dependency of vim-jsx)
  call dein#add('prettier/vim-prettier', { 'build': 'yarn install' }) " Prettier
  call dein#add('reasonml-editor/vim-reason-plus') " ReasonML syntax highlighting
  call dein#add('Shougo/neco-syntax') " syntax source for deoplete
  call dein#add('slim-template/vim-slim') " Slim syntax highlighting
  call dein#add('tpope/vim-rails')

  call dein#end()
  call dein#save_state()
endif

" To clean up uninstalled/commented plugins, run:
" call map(dein#check_clean(), \"delete(v:val, 'rf')\")

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
" Status Bar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_theme = 'bubblegum'
let g:airline#extensions#tabline#enabled = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.readonly = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Speed Improvements for Deoplete
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()

" Autocomplete and cycle from top-to-bottom of suggestions using <Tab>.
" inoremap <expr><TAB> pumvisible() ? "\<c-n>" : "\<TAB>"

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

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" inoremap <expr><C-g>       deoplete#refresh()
" inoremap <expr><C-e>       deoplete#cancel_popup()
" inoremap <silent><expr><C-l>       deoplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

" inoremap <expr> '  pumvisible() ? deoplete#close_popup() : "'"

call deoplete#custom#source('_', 'matchers', ['matcher_head'])
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'matcher_length',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

call deoplete#custom#option('keyword_patterns', {
      \ '_': '[a-zA-Z_]\k*\(?',
      \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
      \ })

call deoplete#custom#option('camel_case', v:true)
call deoplete#custom#option('auto_complete_delay', 0)
call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#option('min_pattern_length', 1)

" call deoplete#custom#option('sources', {
" \ '_': ['buffer'],
" \ 'cpp': ['buffer', 'tag'],
" \})

call deoplete#custom#var('omni', 'input_patterns', {
      \ 'ruby': ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::'],
      \ 'java': '[^. *\t]\.\w*',
      \ '_': '[^. *\t]\.\w*',
      \})

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic Whitespace Trimming and Formatting (for select filetypes)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists("formatting_autocommands_loaded")
  let formatting_autocommands_loaded = 1

  " Trim trailing whitespace before saving code files.
  autocmd BufWritePre *.rb     :%s/\s\+$//e
  autocmd BufWritePre *.rake   :%s/\s\+$//e
  autocmd BufWritePre *.sass   :%s/\s\+$//e

  " Use Prettier, but only for select filetypes.
  let g:prettier#autoformat = 0
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue :Prettier
endif

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
" Prettier
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:prettier#config#print_width = 120
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#parser = 'babylon'
let g:prettier#config#config_precedence = 'prefer-file'
let g:prettier#config#prose_wrap = 'preserve'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
set viminfo='100,f1,<50,s10,h,n~/.config/nvim/viminfo
set backupdir=~/.config/nvim/.backup//
set directory=~/.config/nvim/.swap//

"
" Plugins
"
set runtimepath+=~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim
if dein#load_state('/Users/paul/.config/nvim/bundle')
  call dein#begin('/Users/paul/.config/nvim/bundle')

  " Let dein manage dein.
  call dein#add('/Users/paul/.config/nvim/bundle/repos/github.com/Shougo/dein.vim')

  " Baseline
  call dein#add('tpope/vim-sensible') " sensible defaults
  call dein#add('Shougo/denite.nvim') " unite all interfaces
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'}) " async execution

  " Visual
  call dein#add('altercation/vim-colors-solarized') " colors
  call dein#add('vim-airline/vim-airline') " status line
  call dein#add('vim-airline/vim-airline-themes') " status line colors

  " Language-Specific
  call dein#add('vim-ruby/vim-ruby')
  call dein#add('osyo-manga/vim-monster') " Ruby code completion
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('slim-template/vim-slim')
  call dein#add('digitaltoad/vim-jade')
  call dein#add('paulrex/yaml-vim')
  call dein#add('fatih/vim-go')
  call dein#add('vim-erlang/vim-erlang-runtime')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('Shougo/neco-syntax')

  " TODO: Explore these plugins later.
  " call dein#add('tpope/vim-commentary')

  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  " On startup, install not-installed plugins.
  call dein#install()
endif

"
" Syntax Highlighting
"
filetype plugin indent on
syntax enable

"
" Autocompletion
"
let g:deoplete#enable_at_startup = 1
" Autocomplete and cycle from top-to-bottom of suggestions using <Tab>.
inoremap <expr><TAB> pumvisible() ? "\<c-n>" : "\<TAB>"

"
" Colors
"
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
  autocmd BufWritePre *.sass   :%s/\s\+$//e

  " Set filetypes for exotic extensions to get syntax highlighting.
  autocmd BufNewFile,BufRead *.hql        set filetype=sql
  autocmd BufNewFile,BufRead *.hql.erb    set filetype=eruby.sql
  autocmd BufNewFile,BufRead *.coffee.erb set filetype=eruby.coffee
endif

"
" Set up status bar.
"
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme = 'bubblegum'

"
" Set up Denite.
"
" Use Ctrl+P to pull up a list of all the files in the Git repo.
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '--cached', '--others', '--exclude-standard', '--full-name'])
nnoremap <C-P> :<C-u>execute 'DeniteProjectDir' 'file_rec/git'<CR>
" Use up and down arrow keys to navigate the list.
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>',     'noremap')
call denite#custom#map('insert', '<Up>',   '<denite:move_to_previous_line>', 'noremap')

"
" Set up vim-go.
"
if !exists("go_autocommands_loaded")
  let go_autocommands_loaded = 1
  au FileType go nmap <leader>r <Plug>(go-run)
  au FileType go nmap <leader>b <Plug>(go-build)
  au FileType go nmap <leader>t <Plug>(go-test)
  au FileType go nmap <leader>c <Plug>(go-coverage)
  au FileType go nmap <Leader>ds <Plug>(go-def-split)
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>s <Plug>(go-implements)
endif
" Configure syntax-highlighting for functions, methods, and structs.
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" Automatically insert import paths as well.
let g:go_fmt_command = "goimports"

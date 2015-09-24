" General

set nocompatible
filetype off
set so=7
set encoding=utf8
set modelines=0
syntax enable

" Vundle {

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bling/vim-airline'
Plugin 'Shougo/vimproc.vim'
Plugin 'vim-scripts/Conque-Shell'

" Text manipulation
Plugin 'vim-scripts/Align'
Plugin 'vim-scripts/Gundo'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
Plugin 'michaeljsmith/vim-indent-object'

" Haskell
Plugin 'raichoo/haskell-vim'
Plugin 'enomsg/vim-haskellConcealPlus'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'Twinside/vim-hoogle'

" Elm Plugin
Plugin 'lambdatoast/elm.vim'

" SML
Plugin 'chilicuil/vim-sml-coursera'

if filereadable(expand("~/.vim.local/bundles.vim"))
  source ~/.vim.local/bundles.vim
endif

call vundle#end()
" }

set wildmenu
set wildmode=list:longest,full

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
noremap ,, ,
set tm=2000

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

" Always show current position
set ruler
set number
" set undofile
set relativenumber

au FocusLost * :wa

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:▸\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Height of the command bar
set cmdheight=2

set backspace=eol,start,indent
set whichwrap+=<,>,h,l


" Search && Replace {

" For normal regular expressions in Vim
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set gdefault
" }

" Navigation {
set showmatch
set mat=2

nnoremap <tab> %
vnoremap <tab> %

set noerrorbells
set vb t_vb=

" Windows {
nmap <leader>sh :leftabove  vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove  new<CR>
nmap <leader>sj :rightbelow new<CR>

" Navigation in windows
noremap <c-h> <c-w>h
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-l> <c-w>l
" }


" Mouse {
nnoremap <leader>ma :set mouse=a<cr>
nnoremap <leader>mo :set mouse=<cr>
set mouse=a
" }

map <silent> <leader>r :redraw!<CR>

" filetype {
filetype plugin on
filetype indent on

"}

" Source the vimrc file after saving it
augroup sourcing
  autocmd!
  autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

" indentation {

" spaces instead of tabs
set expandtab

set smarttab

set shiftwidth=4
set tabstop=4
set ai
set si
set wrap

" Linebreak on 500 characters
set lbr
set tw=500

" Disable highlight when <leader><cr> is pressed
" but preserve cursor coloring
nmap <silent> <leader><cr> :noh\|hi Cursor guibg=red<cr>

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

set laststatus=2

" Spell checking {{{

" Pressing ,ss will toggle and untoggle spell checking
set spelllang=pt,en
map <leader>ss :setlocal spell!<cr>

" }}}

"
nnoremap <leader>t :! tree\|less <cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>W zz
nnoremap <leader>q :q<cr>
nnoremap <leader><leader> <c-^>

" map escape key to ;; 
inoremap fd <ESC>
nnoremap ; :

" Color {

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

set background=dark
colorscheme solarized

" Adjust signscolumn and syntastic to match wombat
hi! link SignColumn LineNr
hi! link SyntasticErrorSign ErrorMsg
hi! link SyntasticWarningSign WarningMsg

" Use pleasant but very visible search hilighting
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search

" Match wombat colors in nerd tree
hi Directory guifg=#8ac6f2

" Searing red very visible cursor
hi Cursor guibg=red

" Use same color behind concealed unicode characters
hi clear Conceal

" Don't blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif
set t_Co=256

"
" }

" Use large font by default in MacVim
set gfn=Inconsolata:h16

nmap <silent> <leader>u :GundoToggle<CR>
" ControlP
nnoremap <silent> <leader>o :CtrlP<CR>
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git)$' }

" previous buffer, next buffer
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

" Alignment {

" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align

" Copy/paste to/from the system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

source ~/.vimrc.haskell


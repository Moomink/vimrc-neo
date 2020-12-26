set encoding=utf-8
scriptencoding utf-8
set fileformats=unix,dos,mac
set ambiwidth=double
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932

set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4

set autowrite
set number
set cursorline

set showmatch

filetype off
set wildmenu
set history=5000

set shell=pwsh

if &compatible
  set nocompatible
endif


" Add the dein installation directory into runtimepath
if has('vim_starting')
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
endif


call neobundle#begin(expand('~/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/deoplete.nvim'
if !has('nvim')
  NeoBundle 'roxma/nvim-yarp'
  NeoBundle 'roxma/vim-hug-neovim-rpc'
 endif

NeoBundle 'natebosch/vim-lsc'
" NeoBundle 'tomasr/molokai'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'dart-lang/dart-vim-plugin'
NeoBundle 'natebosch/vim-lsc-dart'
NeoBundle 'ConradIrwin/vim-bracketed-paste'

call neobundle#end()

filetype plugin indent on
syntax enable
colorscheme molokai

set t_Co=256 
set laststatus=2 
set showmode 
set showcmd 
set ruler 
set shortmess-=F

NeoBundleCheck

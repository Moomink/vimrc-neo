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
set clipboard+=unnamed

set showmatch

" Tab settings according to filetype (https://stackoverflow.com/questions/39783724/vim-airline-config-screwed-up)
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype eruby setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

noremap ^ $
noremap $ ^
noremap <C-w><Tab> <C-w>w

tnoremap <Esc> <C-\><C-n>

filetype off
set wildmenu
set history=5000

if has("win32")
    set shell=pwsh
    set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -c
    set shellquote=\"
    set shellxquote= 
endif

if &compatible
  set nocompatible
endif


" Add the dein installation directory into runtimepath
if has('vim_starting')
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim/

  if !isdirectory(expand("~/.config/nvim/bundle/neobundle.vim/"))
      echo "install NeoBundle..."
      :call system("git clone git://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim")
    endif
endif


call neobundle#begin(expand('~/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/deoplete.nvim'
if !has('nvim')
  NeoBundle 'roxma/nvim-yarp'
  NeoBundle 'roxma/vim-hug-neovim-rpc'
 endif

NeoBundle 'prettier/vim-prettier'
NeoBundle 'natebosch/vim-lsc'
NeoBundle 'nightsense/seabird'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'dart-lang/dart-vim-plugin'
NeoBundle 'natebosch/vim-lsc-dart'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle 'whatyouhide/vim-gotham'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'simeji/winresizer'

NeoBundle 'shime/vim-livedown'
let g:livedown_browser= "chrome"

NeoBundle 'fatih/vim-go'
let g:go_version_warning = 0

call neobundle#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'luna'
"let g:airline_powerline_fonts = 1

filetype plugin indent on
syntax enable
colorscheme  gotham256 "テーマ設定

set t_Co=256
set laststatus=2
set showmode
set showcmd
set ruler
set shortmess-=F

NeoBundleCheck

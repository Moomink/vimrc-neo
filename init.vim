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
autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 iskeyword+=-
autocmd Filetype dart setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

noremap ^ $
noremap $ ^
noremap <C-w><Tab> <C-w>w
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

imap <C-a>  <Home>
imap <C-e>  <End>

tnoremap <Esc> <C-\><C-n>

filetype off
filetype plugin indent on
set wildmenu
set history=5000

set shell=zsh

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
      call system("git clone git://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim")
  endif
endif

if has("win32")
  let g:python3_host_prog = 'C:\Python39\python.exe'
  let g:python_host_prog = 'C:\Python27\python.exe'
endif

call neobundle#begin(expand('~/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

"NeoBundle 'Shougo/deoplete.nvim'
"let g:deoplete#enable_at_startup = 1

if !has('nvim')
  NeoBundle 'roxma/nvim-yarp'
  NeoBundle 'roxma/vim-hug-neovim-rpc'
endif

NeoBundle 'prettier/vim-prettier'
"NeoBundle 'natebosch/vim-lsc'
"NeoBundle 'nightsense/seabird'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'dart-lang/dart-vim-plugin'
" NeoBundle 'natebosch/vim-lsc-dart'
let g:dart_format_on_save = 1

NeoBundle 'neoclide/coc.nvim', 'release'

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Terminal Shortvut
nmap <A-C-t>     :tabnew +term<Enter>
nmap <A-n>     :set number!<Enter>

let mapleader = "\\"

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
nmap <C-A-l>    <Plug>(coc-format)
imap <C-A-l>    <Plug>(coc-format)

NeoBundle 'thosakwe/vim-flutter'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle 'whatyouhide/vim-gotham'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'simeji/winresizer'


NeoBundle 'mattn/emmet-vim'


NeoBundle 'shime/vim-livedown'
let g:livedown_browser= "chrome"

NeoBundle 'mattn/vim-goimports'

" Rust Lang
NeoBundle 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

set completeopt+=menuone

" NeoBundle 'fatih/vim-go'
" let g:go_version_warning = 0

NeoBundle '907th/vim-auto-save'
let g:auto_save = 0
let g:auto_save_silent = 1
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
augroup END

" css color preview
NeoBundle 'ap/vim-css-color'

NeoBundle 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

NeoBundle 'lervag/vimtex'
let g:tex_coceal=''

" Japanese Input
NeoBundle 'vim-denops/denops.vim'
NeoBundle 'vim-skk/skkeleton'
NeoBundle 'Shougo/ddc.vim'
NeoBundle 'Shougo/ddc-sorter_rank'
NeoBundle 'Shougo/ddc-matcher_head'

NeoBundle 'LumaKernel/ddc-file'
NeoBundle 'Shougo/pum.vim'
NeoBundle 'Shougo/ddc-sorter_rank'
NeoBundle 'Shougo/ddc-matcher_head'
NeoBundle 'Shougo/ddc-around'
NeoBundle 'Shougo/ddc-converter_remove_overlap'



imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)


call neobundle#end()

call skkeleton#config({
\'globalJisyo': expand('~/.skkeleton/SKK-JISYO.L'),
\'eggLikeNewline':v:true,
\'keepState':v:false,
\'userJisyo': expand('~/.skkleton/USER'),
\})
call skkeleton#config({'completionRankFile': '~/.skkeleton/rank.json'})

function DdcSettings() abort
    call ddc#custom#patch_global('autoCompleteEvents',
    \   ['InsertEnter', 'TextChangedI', 'TextChangedP'])
    call ddc#custom#patch_global('sources', ['skkeleton','around','file'])
    call ddc#custom#patch_global('sourceOptions', {
    \   '_': {
    \     'matchers': ['matcher_head'],
    \     'sorters': ['sorter_rank']
    \   },
    \   'skkeleton': {
    \     'mark': 'skkeleton',
    \     'matchers': ['skkeleton'],
    \     'sorters': [],
    \     'minAutoCompleteLength': 2,
    \   },
    \   'around': {'mark':'Around'},
    \   'file': {
    \   'mark': 'file',
    \   'isVolatile': v:true,
    \   'forceCompletionPattern': '\S/\S*'
    \  }
    \ })
endfunction

function s:enable_ddc() abort
  "call CocDisable()
  let b:coc_suggest_disable = 1
  call DdcSettings()
endfunction

function s:disable_ddc() abort
  "call CocEnable()
  let b:coc_suggest_disable = 0
  call ddc#custom#patch_global('autoCompleteEvents', [])
endfunction

" initialize
call <sid>disable_ddc()


augroup skkeleton-ddc
  autocmd!
  autocmd User skkeleton-enable-pre  call <sid>enable_ddc()
  autocmd User skkeleton-disable-pre call <sid>disable_ddc()
augroup END

call ddc#enable()
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'luna'
"let g:airline_powerline_fonts = 1

filetype plugin indent on
syntax enable
colorscheme  gotham256 "テーマ設定


" HTML
augroup HTMLANDXML
  autocmd!
  autocmd Filetype html inoremap <buffer> </<CR> </<C-x><C-o><ESC>F>a<CR><ESC>O
  autocmd Filetype html inoremap <buffer> </<Tab> </<C-x><C-o><ESC>F>a
augroup END


set t_Co=256
set laststatus=2
set showmode
set conceallevel=0
set showcmd
set ruler
set shortmess-=F
set mouse=a


" 背景透過
"highlight Normal ctermbg=none
"highlight NonText ctermbg=none
"highlight LineNr ctermbg=none
"highlight Folded ctermbg=none
"highlight EndOfBuffer ctermbg=none

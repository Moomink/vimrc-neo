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
autocmd Filetype dart setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

noremap ^ $
noremap $ ^
noremap <C-w><Tab> <C-w>w

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

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
      :call system("git clone git://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim")
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
NeoBundle 'natebosch/vim-lsc'
NeoBundle 'nightsense/seabird'
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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)



NeoBundle 'thosakwe/vim-flutter'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle 'whatyouhide/vim-gotham'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'simeji/winresizer'


"Coc で代用
"NeoBundle 'w0rp/ale'

let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '⚠'

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
      \   'c' : ['clangd'],
      \   'cpp' : ['clangd']
  \}


NeoBundle 'shime/vim-livedown'
let g:livedown_browser= "chrome"

"NeoBundle 'prabirshrestha/asyncomplete.vim'
"NeoBundle 'prabirshrestha/asyncomplete-lsp.vim'
NeoBundle 'prabirshrestha/vim-lsp'
NeoBundle 'mattn/vim-lsp-settings'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'thomasfaingnaert/vim-lsp-snippets'
NeoBundle 'thomasfaingnaert/vim-lsp-ultisnips'
"NeoBundle 'hrsh7th/vim-vsnip'
"NeoBundle 'hrsh7th/vim-vsnip-integ'
NeoBundle 'mattn/vim-goimports'

" Rust Lang
NeoBundle 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <C-]> <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> <Leader>d <plug>(lsp-type-definition)
  nmap <buffer> <Leader>r <plug>(lsp-references)
  nmap <buffer> <Leader>i <plug>(lsp-implementation)
"  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
" let g:asyncomplete_auto_popup = 1
" let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']

let g:lsp_settings = {}
let g:lsp_settings['gopls'] = {
  \  'workspace_config': {
  \    'usePlaceholders': v:true,
  \    'analyses': {
  \      'fillstruct': v:true,
  \    },
  \  },
  \  'initialization_options': {
  \    'usePlaceholders': v:true,
  \    'analyses': {
  \      'fillstruct': v:true,
  \    },
  \  },
  \}

" For snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

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

call neobundle#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'luna'
"let g:airline_powerline_fonts = 1

filetype plugin indent on
syntax enable
colorscheme  gotham256 "テーマ設定

" HTML
augroup HTMLANDXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

set t_Co=256
set laststatus=2
set showmode
set showcmd
set ruler
set shortmess-=F
set mouse=a
NeoBundleCheck

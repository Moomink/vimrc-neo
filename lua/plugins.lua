local fn = vim.fn


-- Initilaize Installl
local ensure_packer = function()
    local install_path = fn.stdpath('config') .. 'lua/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.opt.runtimepath:append(install_path)
        return true
    end
    vim.opt.runtimepath:append(install_path)
    return false
end

local packer_bootstrap = ensure_packer()


return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'bronson/vim-trailing-whitespace'
    use {
        'Yggdroot/indentLine',
        config = function()
            vim.cmd([[
                let g:indentLine_color_term = 0xFF
                "let g:indentLine_bgcolor_term = 0xEE
                let g:indentLine_first_char = '░'
                let g:indentLine_showFirstIndentLevel = 1
                let g:indentLine_char_list = ['❙','¦','|']
                let g:indentLine_leadingSpaceChar = '░'
                let g:indentLine_leadingSpaceEnabled = 0
            ]])
        end
    }

    use 'ConradIrwin/vim-bracketed-paste'


    use 'simeji/winresizer'
    use 'ap/vim-css-color'
    use {
        'scrooloose/nerdtree',
        config = 'vim.keymap.set("","<C-n>",":NERDTreeToggle<CR>")'
    }


    -- Utility
    use 'lambdalisue/suda.vim'
    use 'jiangmiao/auto-pairs'
    use 'tpope/vim-surround'
    use 'tomtom/tcomment_vim'
    use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    })
    use 'vimwiki/vimwiki'

    -- Theme
    use {
        '4513ECHO/vim-colors-hatsunemiku',
        -- TODO add hatsune symblic link
        config = function()
            if vim.fn.has("gui_running") ~= 1 and vim.fn.has('termguicolors') == 1 then
                vim.opt.termguicolors = true
            end
            vim.cmd [[colorscheme hatsunemiku]]
        end
    }
    use 'whatyouhide/vim-gotham'
    use 'arcticicestudio/nord-vim'
    use 'tomasiser/vim-code-dark'

    use 'vimwiki/vimwiki'

    use {
        'vim-airline/vim-airline',
        config = function()
            vim.cmd([[
                let g:airline_powerline_fonts = 1
                let g:airline_theme='codedark'
            ]])
        end
    }
    use 'vim-airline/vim-airline-themes'
    use {
        'ryanoasis/vim-devicons',
        config = function()
            vim.cmd([[
                let g:airline#extensions#tabline#enabled = 1
            ]])
        end
    }
    use 'lambdalisue/nerdfont.vim'


    -- Language Server Protocol
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        'lukas-reineke/lsp-format.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/vim-vsnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline'

    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

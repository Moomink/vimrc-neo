local fn = vim.fn


-- Initilaize Installl
local ensure_packer = function()
    local install_path = fn.stdpath('config') .. '/lua/pckr.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', 
        '--depth', '1', 
        '--filter=blob:none','https://github.com/lewis6991/pckr.nvim', install_path })
        vim.opt.runtimepath:append(install_path)
    end
    vim.opt.runtimepath:append(install_path)
end

local packer_bootstrap = ensure_packer()


local cmd = require('pckr.loader.cmd')
local keys = require('pckr.loader.keys')

require('pckr').setup{
    log = { level = "info" }
}

require('pckr').add{

    'bronson/vim-trailing-whitespace';

    {
        'Yggdroot/indentLine',
        config = function()
            vim.cmd[[
                let g:indentLine_color_term = 0xFF
                "let g:indentLine_bgcolor_term = 0xEE
                let g:indentLine_first_char = '░'
                let g:indentLine_showFirstIndentLevel = 1
                let g:indentLine_char_list = ['❙','¦','|']
                let g:indentLine_leadingSpaceChar = '░'
                let g:indentLine_leadingSpaceEnabled = 0
            ]]
        end
    };

    'ConradIrwin/vim-bracketed-paste';


    {
        'simeji/winresizer',
        cond = keys('n','<C-r>')
    };

    'ap/vim-css-color';

    {
        'scrooloose/nerdtree',
        requires = "vim-devicons",
        config = function()
	        vim.keymap.set("","<C-n>",":NERDTreeToggle<CR>")
	    end
    };


    -- Utility
    {
        'lambdalisue/suda.vim',
        cond = {
	  cmd ('SudaWrite', 'SudaRead')
    	}
    };
    'jiangmiao/auto-pairs';
    'tpope/vim-surround';
    'tomtom/tcomment_vim';


    -- Theme
    {
        '4513ECHO/vim-colors-hatsunemiku',
        -- TODO add hatsune symblic link
        config = function()
            if vim.fn.has("gui_running") ~= 1 and vim.fn.has('termguicolors') == 1 then
                vim.opt.termguicolors = true
            end
        end
    };
    'whatyouhide/vim-gotham';
    'arcticicestudio/nord-vim';
    'tomasiser/vim-code-dark';

    -- 'vimwiki/vimwiki';

    {
        'vim-airline/vim-airline',
        requires = {"vim-airline-themes", "vim-devicons", "nerdfont.vim"},
        config = function()
            vim.cmd[[
                let g:airline_powerline_fonts = 1
                let g:airline#extensions#tabline#enabled = 1
                let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
            ]]
        end
    };
    {
	    'vim-airline/vim-airline-themes',
	    config = function()
	        vim.cmd([[
	            let g:airline_theme='codedark'
	        ]])
        end
    };
    {
        'ryanoasis/vim-devicons',
        config = function()
            vim.cmd([[
            ]])
        end
    };
    'lambdalisue/nerdfont.vim';


    -- Language Server Protocol
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        'lukas-reineke/lsp-format.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'mhartington/formatter.nvim'
    };

}

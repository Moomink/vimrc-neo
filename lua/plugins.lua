local fn = vim.fn


-- Initilaize Installl
local ensure_packer = function()
  local install_path = fn.stdpath('config') .. '/lua/pckr.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone',
      '--depth', '1',
      '--filter=blob:none', 'https://github.com/lewis6991/pckr.nvim', install_path })
    vim.opt.runtimepath:append(install_path)
  end
  vim.opt.runtimepath:append(install_path)
end

local packer_bootstrap = ensure_packer()


local cmd = require('pckr.loader.cmd')
local keys = require('pckr.loader.keys')

require('pckr').setup {
  log = { level = "info" }
}


require('pckr').add {

  'bronson/vim-trailing-whitespace',

  {
    'Yggdroot/indentLine',
    config = function()
      vim.cmd [[
        let g:indentLine_color_term = 0xFF
        "let g:indentLine_bgcolor_term = 0xEE
        let g:indentLine_first_char = '░'
        let g:indentLine_showFirstIndentLevel = 1
        let g:indentLine_char_list = ['❙','¦','|']
        let g:indentLine_leadingSpaceChar = '░'
        let g:indentLine_leadingSpaceEnabled = 0
      ]]
    end
  },

  'ConradIrwin/vim-bracketed-paste',


  {
    'simeji/winresizer',
    cond = keys('n', '<C-e>')
  },

  'ap/vim-css-color',


  {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- optionally enable 24-bit colour
      vim.opt.termguicolors = true
      -- custom mappings
      local api = require "nvim-tree.api"
      vim.keymap.set('', '<C-n>', api.tree.toggle)
      local tree = require("nvim-tree")
      tree.setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },

      })
    end
  },


  -- Utility

  {
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local noice = require("noice")
      noice.setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
  },

  {
    "amitds1997/remote-nvim.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("remote-nvim").setup({
        ssh_config = {
          ssh_prompt =  {
				    {
					    match = "Enter passphrase for key",
					    type = "secret", -- パスフレーズはシークレットとして扱う
					    value_type = "static", -- 毎回新しいパスフレーズを入力するか
				      value = "", -- 初期値
				    },
          },
        },
      })
    end,
    cond = {
      cmd('RemoteStart'),
      cmd('RemoteStop'),
      cmd('RemoteInfo'),
      cmd('RemoteLog'),
      cmd('RemoteCleanup'),
    },
  },

  --- mini.nvim
  {
    'echasnovski/mini.map',
    branch = 'stable',
    config = function()
      vim.keymap.set("", "<C-A-n>", ":lua MiniMap:toggle()<CR>")
      local minimap = require('mini.map')
      minimap.setup({
        integrations = {
          minimap.gen_integration.diagnostic({
            error = 'DiagnosticFloatingError',
            warn  = 'DiagnosticFloatingWarn',
          }),
          minimap.gen_integration.gitsigns(),
        },
        symbols = { encode = minimap.gen_encode_symbols.dot("4x2")
        },
        window = {
          width = 15,
          focusable = true,
        },
      })
      minimap.toggle()
    end
  },
  {
    'echasnovski/mini.indentscope',
    branch = 'stable',
    config = function()
      require('mini.indentscope').setup()
    end
  },
  {
    'echasnovski/mini.surround',
    branch = 'stable',
    config = function()
      require('mini.surround').setup()
    end
  },


  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '┃' },
          delete       = { text = '_' },
        },
        signs_staged = {
          add          = { text = '+' },
          change       = { text = '┃' },
          delete       = { text = '_' },
        },
      })
     end
   },

  {
    'akinsho/toggleterm.nvim',
    config = function()
      require("toggleterm").setup()
    end,
    cond = cmd('ToggleTerm'),
  },
  {
    'lambdalisue/suda.vim',
    cond = {
      cmd('SudaWrite'),
      cmd('SudaRead')
    }
  },
  'jiangmiao/auto-pairs',
  'tpope/vim-surround',
  'tomtom/tcomment_vim',
  {
    'willothy/veil.nvim',
    requires = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim"
    }
  },


  {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')
			vim.keymap.set('n', 'ff', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', 'fg', builtin.live_grep, { desc = 'Telescope live grep' })
			vim.keymap.set('n', 'fb', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', 'fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
  },


  -- Theme
  {
    '4513ECHO/vim-colors-hatsunemiku',
    -- TODO add hatsune symblic link
    config = function()
      if vim.fn.has("gui_running") ~= 1 and vim.fn.has('termguicolors') == 1 then
        vim.opt.termguicolors = true
      end
    end
  },
  'whatyouhide/vim-gotham',
  'arcticicestudio/nord-vim',
  'tomasiser/vim-code-dark',

  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup{
        options = { theme = 'papercolor_light' },
      }
    end
  },
  {
    'ryanoasis/vim-devicons',
    config = function()
      vim.cmd([[
            ]])
    end
  },
  'lambdalisue/nerdfont.vim',


  -- Language Server Protocol
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  'lukas-reineke/lsp-format.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/vim-vsnip',
  'hrsh7th/cmp-cmdline',

  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        lsp_format = "first"
      })

			vim.api.nvim_create_user_command("Format", function(args)
		 		local range = nil
		 	  if args.count ~= -1 then
		 	  	local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		 	   	range = {
		 	    	start = { args.line1, 0 },
		 	     	["end"] = { args.line2, end_line:len() },
		 	   	}
		 	 end
		 	 require("conform").format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })
    end,
		cond = cmd("Format")
  },

  {
		"zapling/mason-conform.nvim",
    requires = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
		config = function()
			require("mason-conform").setup({})
		end
  },


  "github/copilot.vim",


}

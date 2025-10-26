require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("lsp-format").setup {}

require("mason-lspconfig").setup({ function(server)
    local opt = {
        capabilities = require('cmp_nvim_lsp').update_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        ),
        on_attach = require("lsp-format").on_attach
    }
    require('lspconfig')[server].setup(opt)
end
})

-- Dart
require("lspconfig").dartls.setup{
    cmd = { "dart", "language-server", "--protocol=lsp" },
}

-- Go
require("lspconfig").gopls.setup{
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    root_dir = require("lspconfig").util.root_pattern("go.mod", "go.sum"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}


-- Formatter
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

local formatter_list = {};

local mason_registry = require("mason-registry")
local mason_package = require("mason-core.package")

for _, pkg in pairs(mason_registry.get_all_package_specs()) do
    if mason_registry.is_installed(pkg.name) ~= true then
        goto continue
    end

    local package = mason_registry.get_package(pkg.name)

    local categories = pkg.categories
    for _, cat in pairs(categories) do
        if cat == mason_package.Cat.Formatter then
            package:get_receipt():if_present(function(receipt)
                formatter_list[pkg.name] = {
                    command = package:get_install_path() .. "/" .. receipt.links.bin[receipt.name],
                }
            end)
        end
    end
    ::continue::
end


require("conform").setup({
    log_level = vim.log.levels.INFO,
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
})




-- https://zenn.dev/botamotch/articles/21073d78bc68bf
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format{async = true}<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<C-A-l>', '<cmd>lua vim.lsp.buf.format{async = true}<CR>')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040

]]

-- completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "codeium" }, -- codeium
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-a>'] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    experimental = {
        ghost_text = true,
    },

		performance = {
				fetching_timeout = 2000,
		},


    window = {
        --completion = cmp.config.window.bordered(),
        --documentation = cmp.config.window.bordered(),
    },

})

cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
})

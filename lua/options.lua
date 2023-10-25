-- set option
local options = {
    encoding = "utf-8",
    fileformats = { "unix", "mac", "dos" },
    fileencodings = { "utf-8", "euc-jp", "cp932" },
    expandtab = true,
    smarttab = true,
    tabstop = 4,
    softtabstop = 4,
    smartindent = true,
    ---swapsync = "sync",
    autoread = true,
    shiftwidth = 4,
    wrap = false,
    number = true,
    cursorline = true,
    showmatch = true,
    history = 5000,
    showmode = true,
    showcmd = true,
    mouse = "a",
    wildmenu = true,
    relativenumber = true,
}

vim.opt.completeopt:append({ menuone = true })

for k, v in pairs(options) do
    vim.opt[k] = v
end




-- HTML
vim.cmd([[
    augroup HTMLANDXML
        autocmd!
        autocmd Filetype html inoremap <buffer> </<CR> </<C-x><C-o><ESC>F>a<CR><ESC>O
        autocmd Filetype html inoremap <buffer> </<Tab> </<C-x><C-o><ESC>F>a
    augroup END
]])


-- 背景透過
vim.cmd([[
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
    highlight LineNr ctermbg=none
    highlight Folded ctermbg=none
    highlight EndOfBuffer ctermbg=none
]])


-- Theme
vim.cmd([[colorscheme hatsunemiku]])

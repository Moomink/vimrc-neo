-- set option
local options = {
	encoding = "utf-8",
	fileformats = {"unix","mac","dos"},
	fileencodings = {"utf-8","euc-jp","cp932"},
	expandtab = true,
	smarttab = true,
	tabstop = 4,
	softtabstop = 4,
	smartindent = true,
	---swapsync = "sync",
	autoread = true,
	shiftwidth = 4,
	number = true,
	cursorline = true,
	showmatch = true,
	history =  5000,
	showmode = true,
	showcmd = true,
	mouse = "a",
	wildmenu = true,
}

vim.opt.completeopt:append({menuone = true})

for k,v in pairs(options) do
        print(k)
	vim.opt[k] = v
end



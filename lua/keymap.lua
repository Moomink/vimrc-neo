-- keymap

local map = vim.keymap


map.set('n', '^', '$')
map.set('n', '$', '^')

map.set('n', '<C-w><Tab>', '<C-w>w')

map.set('i', '{<Enter>', '{}<Left><CR><ESC><S-o>')
map.set('i', '[<Enter>', '[]<Left><CR><ESC><S-o>')
map.set('i', '(<Enter>', '()<Left><CR><ESC><S-o>')

map.set('i', '<C-a>', '<Home>')
map.set('i', '<C-e>', '<End>')

map.set('t', '<Esc>', '<C-\\><C-n>')

map.set('n', '<A-C-t>', ':tabnew +term<Enter>')
map.set('n', '<A-@>', ':sp +term<Enter>')
map.set('n', '<A-n>', ':set number!<Enter>')

map.set('', '<C-Left>', ':tabprevious<CR>')
map.set('', '<C-Right>', ':tabnext<CR>')

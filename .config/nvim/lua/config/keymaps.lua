-- disable help
--vim.keymap.set('n', '<F1>', '<nop>')
--vim.keymap.set('i', '<F1>', '<nop>')

-- Short record
vim.keymap.set('n', 'Q', '@q')

-- Keep the cursor in place while joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- Select (charwise) the contents of the current line, excluding indentation.
vim.keymap.set('n', 'vv', '^vg_')

-- Switch to previous edited buffer
vim.keymap.set('n', '<BS>', '<C-^>')

-- Toggle list, show invisible
vim.keymap.set('n', '<leader>i', ':set list!<cr>')

-- nohl
vim.keymap.set('n', '<leader>/', ':nohl<cr>')

-- Allow continuous indentations in visual mode
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-j>', '<C-w>j')

-- Emacs like navigaion on command mode
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-f>', '<Right>')


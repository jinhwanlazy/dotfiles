-- default
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 6
vim.opt.tags = "./tags;/"
vim.opt.matchtime = 2 
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.listchars = { eol = '↵', tab = '▸▸' }
vim.opt.wrapscan = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'number'
vim.opt.mouse = ""
vim.opt.synmaxcol = 400
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true


-- dirs
vim.opt.backup=true
vim.opt.undofile=true
undodir = vim.fn.expand('~/.cache/nvim/undo/')
backupdir = vim.fn.expand('~/.cache/nvim/backup/')
swapdir = vim.fn.expand('~/.cache/nvim/swapdir/')
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")   
end
if vim.fn.isdirectory(backupdir) == 0 then
	vim.fn.mkdir(backupdir, 'p')
end
if vim.fn.isdirectory(swapdir) == 0 then
	vim.fn.mkdir(swapdir, 'p')
end
vim.opt.undodir=undodir
vim.opt.backupdir=backupdir
vim.opt.directory=swapdir

-- tabs
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.textwidth=0
vim.opt.colorcolumn="80,100"

vim.opt.backupskip="/tmp/*,/private/tmp/*"

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}


local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

local number_toggle = augroup('NumberToggle', { clear = true })
autocmd(
    {"BufEnter", "FocusGained", "InsertLeave"},
    {
        pattern = '*',
        callback = function()
            vim.opt.relativenumber = true
        end,
        group = number_toggle
    }
)
autocmd(
    {"BufEnter", "FocusGained", "InsertLeave"},
    {
        pattern = '*',
        callback = function()
            vim.opt.relativenumber = false
        end,
        group = number_toggle
    })

autocmd(
    "FileType",
    {
        pattern = 'cpp',
        callback = function()
            vim.opt.shiftwidth = 2
            vim.opt.softtabstop = 2
            vim.opt.tabstop = 2
            vim.opt.expandtab = true
            vim.opt.wrap = true
        end,
    })

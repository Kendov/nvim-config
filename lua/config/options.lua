vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- local keymap = vim.api.nvim_set_keymap
local opt = vim.opt
local default_opts = { noremap = true, silent = true }


opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false


-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearence
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = '100'
opt.signcolumn = "yes"
opt.scrolloff = 10


-- Behaviour
opt.backup = false
opt.completeopt = 'menuone,noselect'
opt.mouse = 'a'
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.showmode = false


vim.keymap.set("n", "<C-b>", ":Lex<CR>:vertical resize 30<CR>", { desc = 'Open [F]ile [E]xplorer'})
-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

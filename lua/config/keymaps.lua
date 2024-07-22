---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc string?
local map = function(mode, lhs, rhs, desc)
  local opts = {
    noremap = true,
    silent = true,
    desc = desc,
  }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Terminal Mappings
map('t', '<esc><esc>', '<c-\\><c-n>', 'Enter Normal Mode')

-- Utilities in edit mode
-- Disabled to use nvim-autopairs
-- map('i', '{', '{}<left>', 'Auto close')
-- map('i', '{}', '{}', 'ignore auto close')
-- map('i', '{<CR>', '{<CR>}<Esc>O', 'Auto close')
-- map('i', '(', '()<left>', 'Auto close')
-- map('i', '()', '()', 'Ignore auto close')
-- map('i', '[]', '[]', 'Ignore Auto close')
-- map('i', '"', '""<left>', 'Auto close')
-- map('i', "'", "''<left>", 'Auto close')

-- Save with ctr + s
map('n', '<C-s>', ':w<CR>', 'Save File')

-- Diagnostic keymaps
map('n', '[d', function()
  vim.diagnostic.jump { count = 1 }
end, 'Go to previous [D]iagnostic message')
map('n', ']d', function()
  vim.diagnostic.jump { count = -1 }
end, 'Go to next [D]iagnostic message')
map('n', '<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
map('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

-- duplicate lines
map('n', '<C-j>', 'yyp', 'Copy current line down')
map('n', '<C-k>', 'yyP', 'Copy current line up')
map('v', '<C-j>', "y']p", 'Copy current selection down')
map('v', '<C-k>', 'yP', 'Copy current selection up')

-- center screen during some vertical movemets
map('n', '<C-d>', '<C-d>zz', 'Center screen after scrow down')
map('n', '<C-u>', '<C-u>zz', 'Center screen after scrow up')

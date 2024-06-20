return {
  -- neovim themes
  -- 'folke/tokyonight.nvim',
  -- 'navarasu/onedark.nvim',
  'catppuccin/nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  name = 'catppuccin',
  config = function()
    -- Load the colorscheme here
    -- vim.cmd.colorscheme 'tokyonight-night'
    -- vim.cmd.colorscheme 'onedark'
    require('catppuccin').setup { flavour = 'mocha' }
    vim.cmd.colorscheme 'catppuccin'

    -- You can configure highlights by doing something like
    -- vim.cmd.hi 'Comment gui=none'
  end,
}

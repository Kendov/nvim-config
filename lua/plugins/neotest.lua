return {
  'nvim-neotest/neotest',
  event = 'VeryLazy',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'Issafalcon/neotest-dotnet',
  },
  opts = {
    adapters = {
      function()
        local dotnetTest = require 'neotest-dotnet'
        return dotnetTest
      end,
    },
  },
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = "Run the nearest test"
    },
    {
      '<leader>tf',
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run tests on current file"
    },
    {
      '<leader>ts',
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop tests"
    },
  },
}

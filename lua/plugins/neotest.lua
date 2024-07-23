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
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-dotnet' {
          discovery_root = 'solution',
        },
      },
    }
  end,
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run the nearest test',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run tests on current file',
    },
    {
      '<leader>ta',
      function()
        require('neotest').run.run { suite = true }
      end,
      desc = 'Run all testes',
    },
    {
      '<leader>ts',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Stop tests',
    },
    {
      '<leader>te',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle test explorer',
    },
  },
}

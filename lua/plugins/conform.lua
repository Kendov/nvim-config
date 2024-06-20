return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      csharp = { 'csharpier', 'astyle' },
    },
    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_format = 'fallback',
    -- },
  },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>=',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
}

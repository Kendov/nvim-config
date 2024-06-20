return {

  'tpope/vim-sleuth',
  { 'folke/neoconf.nvim', cmd = 'Neoconf' },
  {
    'ggandor/leap.nvim',
    event = 'VeryLazy',
    config = function()
      local l = require 'leap'
      vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
        l.leap {}
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
        l.leap { backward = true }
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', function()
        l.get_enterable_windows()
      end)
    end,
  },
  'folke/neodev.nvim',
  {
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  { 'lukas-reineke/indent-blankline.nvim', event = 'VeryLazy', main = 'ibl', opts = {} },
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup()
    end,
    keys = {
      {
        '<leader>A',
        function()
          require('harpoon'):list():append()
        end,
        desc = 'harpoon file',
      },
      {
        '<leader>a',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'harpoon quick menu',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'harpoon to file 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'harpoon to file 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'harpoon to file 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'harpoon to file 4',
      },
      {
        '<leader>5',
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'harpoon to file 5',
      },
    },
  },
  {
    'j-hui/fidget.nvim',
    opts = {
      -- options
    },
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },
  { 'kosayoda/nvim-lightbulb' },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    opts = {},
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      {
        '<C-b>',
        '<Cmd>Neotree toggle filesystem reveal right<CR>',
        desc = 'Filesystem (root dir)',
      },
    },
    cmd = { 'Neotree' },
  },
  { 'rcarriga/nvim-notify', opts = {} },
  -- {
  --     "folke/noice.nvim",
  --     event = "VeryLazy",
  --     opts = {
  --         lsp = {
  --             -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --             override = {
  --                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --                 ["vim.lsp.util.stylize_markdown"] = true,
  --                 ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --             },
  --         },
  --         -- you can enable a preset for easier configuration
  --         presets = {
  --             bottom_search = true, -- use a classic bottom cmdline for search
  --             command_palette = true, -- position the cmdline and popupmenu together
  --             long_message_to_split = true, -- long messages will be sent to a split
  --             inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --             lsp_doc_border = false, -- add a border to hover docs and signature help
  --         },
  --     },
  --     dependencies = {
  --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --         "MunifTanjim/nui.nvim",
  --         -- OPTIONAL:
  --         --   `nvim-notify` is only needed, if you want to use the notification view.
  --         --   If not available, we use `mini` as the fallback
  -- "rcarriga/nvim-notify",
  --     }
  -- },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      -- 'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      -- luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
}

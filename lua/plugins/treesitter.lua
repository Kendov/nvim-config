return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    -- config = function()
    --   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    --   ---@diagnostic disable-next-line: missing-fields
    --   require('nvim-treesitter.configs').setup {
    --     ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'c_sharp', 'go' },
    --     -- Autoinstall languages that are not installed
    --     auto_install = true,
    --     highlight = { enable = true },
    --     indent = { enable = true },
    --   }

    --   -- There are additional nvim-treesitter modules that you can use to interact
    --   -- with nvim-treesitter. You should go explore a few and see what interests you:
    --   --
    --   --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --   --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --   --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    -- end,
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "c_sharp",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
            },
        },
    },
}

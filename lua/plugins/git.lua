return {
    {
        "tpope/vim-fugitive",
        event = "VeryLazy"
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    {
        event = "VeryLazy",
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Actions
                map('n', '<leader>gS', gitsigns.stage_buffer, { desc = "stage buffer" } )

                -- stage changes in normal and visual mode
                map('n', '<leader>gs', gitsigns.stage_hunk, { desc = "stage hunk" })
                map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "stage hunk" })
                map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = "undo stage hunk" })
                -- revert changes in normal and visual mode
                map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "reset hunk" })
                map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "reset hunk" })

                map('n', '<leader>gp', gitsigns.preview_hunk, { desc = "preview hunk" })
                map('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })

                -- Text object
                -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end        },
        },
    }

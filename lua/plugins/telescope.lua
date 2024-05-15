return {
    {
        "nvim-telescope/telescope-file-browser.nvim",
        event = 'VeryLazy',
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function ()
            local telescope = require("telescope")
            vim.keymap.set("n", "<space>fb", function()
                telescope.extensions.file_browser.file_browser()
            end)
            telescope.load_extension "file_browser"
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- { 'nvim-telescope/telescope-ui-select.nvim', opts = {} },
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
            vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = '[F]ind [W]ord inside path' })
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find files visible in git' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers'})
        end,
    },
}


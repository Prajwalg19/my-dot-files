return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    cmd = "Telescope",
    keys = {
        { "<leader>fa", "<cmd>Telescope oldfiles<cr>",                                                desc = "Recent files" },
        { "<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,-u<cr>", desc = "Find files" },
        { "<leader>fr", "<cmd>Telescope live_grep<cr>",                                               desc = "Live grep" },
        { "<leader>ht", "<cmd>Telescope colorscheme<cr>",                                             desc = "Color schemes" },
        { "<leader>fw", "<cmd>Telescope buffers sort_lastused=true<cr>",                              desc = "Buffers sorted by last used" }
    },
    config = function()
        local actions = require("telescope.actions")
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                file_ignore_patterns = { "%.class", "node_modules", ".git/", ".cache", "%.o", "%.a", "%.out", "%.pdf" },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                path_display = { "truncate" },
                winblend = 0,
                border = {},
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })
        telescope.load_extension("fzf")
    end
}

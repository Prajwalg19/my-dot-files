return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-file-browser.nvim" },
    cmd = "Telescope",
    keys = {
        { "<leader>fa", "<cmd>Telescope oldfiles<cr>",                   desc = "Telescope" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>",                 desc = "Telescope" },
        { "<leader>fr", "<cmd>Telescope live_grep<cr>",                  desc = "Telescope" },
        { "<leader>ht", "<cmd>Telescope colorscheme<cr>",                desc = "Telescope" },
        { "<leader>fb", "<cmd>Telescope file_browser<cr>",               desc = "File browser" },
        { "<leader>fw", "<cmd>Telescope buffers sort_lastused=true<cr>", desc = "Buffers sorted by last used" }
    },
    -- config = function(_, opts)
    --     local telescope = require("telescope")
    --     local fb_actions = require("telescope").extensions.file_browser.actions
    --
    --     opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
    --         wrap_results = true,
    --         layout_strategy = "horizontal",
    --         layout_config = { prompt_position = "top" },
    --         sorting_strategy = "ascending",
    --         winblend = 0,
    --         mappings = {
    --             n = {},
    --         },
    --     })
    --     opts.pickers = {
    --         diagnostics = {
    --             theme = "ivy",
    --             initial_mode = "normal",
    --             layout_config = {
    --                 preview_cutoff = 9999,
    --             },
    --         },
    --     }
    --     opts.extensions = {
    --         file_browser = {
    --             theme = "dropdown",
    --             -- disables netrw and use telescope-file-browser in its place
    --             hijack_netrw = true,
    --             mappings = {
    --                 -- your custom insert mode mappings
    --                 ["n"] = {
    --                     -- your custom normal mode mappings
    --                     ["a"] = fb_actions.create,
    --                     ["h"] = fb_actions.goto_parent_dir,
    --                     ['c'] = false,
    --                     ["o"] = function(prompt_bufnr)
    --                         require("telescope.actions").select_default(prompt_bufnr)
    --                     end,
    --                     ["<C-u>"] = function(prompt_bufnr)
    --                         for i = 1, 10 do
    --                             actions.move_selection_previous(prompt_bufnr)
    --                         end
    --                     end,
    --                     ["<C-d>"] = function(prompt_bufnr)
    --                         for i = 1, 10 do
    --                             actions.move_selection_next(prompt_bufnr)
    --                         end
    --                     end,
    --                     ["<PageUp>"] = actions.preview_scrolling_up,
    --                     ["<PageDown>"] = actions.preview_scrolling_down,
    --                 },
    --             },
    --         },
    --     }
    --     telescope.setup(opts)
    --     require("telescope").load_extension("fzf")
    --     require("telescope").load_extension("file_browser")
    -- end,

    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "%.class", "node_modules" },
                theme = "center",
                --sorting_strategy = "ascending",
                -- layout_config = {
                --     horizontal = {
                --         prompt_position = "top",
                --     },
                -- },

            },
            extensions = {
                file_browser = {
                    theme = "ivy",
                    -- disables netrw and use telescope-file-browser in its place
                    initial_mode = "normal",
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                        },
                        ["n"] = {
                            ["a"] = function(prompt_bufnr)
                                local fb_actions = require("telescope._extensions.file_browser.actions")
                                fb_actions.create(prompt_bufnr)
                            end,
                            ["<C-u>"] = function(prompt_bufnr)
                                for i = 1, 10 do
                                    actions.move_selection_previous(prompt_bufnr)
                                end
                            end,
                            ["<C-d>"] = function(prompt_bufnr)
                                for i = 1, 10 do
                                    actions.move_selection_next(prompt_bufnr)
                                end
                            end,

                        },
                    },
                },
            },
        })
    end

}

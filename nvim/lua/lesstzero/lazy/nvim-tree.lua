return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    -- event="VeryLazy",
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true
        -- OR setup with some options
        vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
        require("nvim-tree").setup({
            on_attach = "default",
            hijack_cursor = false,
            auto_reload_on_write = true,
            disable_netrw = false,
            hijack_netrw = true,
            hijack_unnamed_buffer_when_opening = false,

            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
                relativenumber = true,
            },
            renderer = {
                group_empty = false,
                indent_markers = {
                    enable = false,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                    },
                },

            },
            update_focused_file = {
                -- enable = true,
                update_root = {
                    enable = false,
                    ignore_list = {},
                },
                exclude = false,
            },
        })
    end
}

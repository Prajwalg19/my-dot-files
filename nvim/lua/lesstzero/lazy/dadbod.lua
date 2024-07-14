return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod',                     lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    keys = {
        { "<F10>", ":DBUIToggle<CR>", desc = "toggle the undoree" },
    },
    init = function()
        -- Configuration
        vim.g.db_ui_winwidth = 30
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_show_help = 0
        vim.g.db_ui_disable_progress_bar = 1
        vim.g.db_ui_win_position = "right"
        vim.g.db_ui_show_database_icon = 1
        vim.g.dbs = {
            dev = 'postgres://postgres:7975@localhost:5432/recipeguru',
            mongoLocal =
            "mongodb://127.0.0.1:27017/AllocatePDO?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.2.11"
        }
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'dbout' },
            callback = function()
                vim.opt.foldenable = false
            end,
        })
    end,
}

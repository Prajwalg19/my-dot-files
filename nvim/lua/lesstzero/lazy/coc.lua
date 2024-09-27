return {
    "neoclide/coc.nvim",
    branch = "release",
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function()
        local keyset = vim.keymap.set
        local opts = { silent = true, nowait = true, expr = true }

        -- Existing keybindings and configurations
        vim.api.nvim_set_keymap("i", '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<CR>"',
            { expr = true, noremap = true, silent = true })

        keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
        keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

        keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
        keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
        keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
        keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

        function _G.show_docs()
            local cw = vim.fn.expand('<cword>')
            if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
                vim.api.nvim_command('h ' .. cw)
            elseif vim.api.nvim_eval('coc#rpc#ready()') then
                vim.fn.CocActionAsync('doHover')
            else
                vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
            end
        end

        -- Function to enter the floating window
        function _G.enter_float()
            if vim.fn['coc#float#has_float']() == 1 then
                vim.fn['coc#float#jump']()
            end
        end

        -- Use K to show documentation in preview window
        keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

        -- Use KK to enter the floating window
        keyset("n", "KK", '<CMD>lua _G.enter_float()<CR>', { silent = true })

        -- Rest of your existing configuration...

        -- Existing key mappings for scrolling within coc.nvim's floating window
        keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
        keyset("i", "<C-f>",
            'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
        keyset("i", "<C-b>",
            'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
        keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
        keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

        vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

        function _G.check_back_space()
            local col = vim.fn.col('.') - 1
            return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
        end

        -- Existing highlight group and autocmd
        vim.api.nvim_create_augroup("CocGroup", {})
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "CocGroup",
            command = "silent call CocActionAsync('highlight')",
            desc = "Highlight symbol under cursor on CursorHold"
        })

        keyset("n", "<leader>s", "<Plug>(coc-rename)", { silent = true })

        local remap = vim.api.nvim_set_keymap
        local npairs = require('nvim-autopairs')
        npairs.setup({ map_cr = false })

        _G.MUtils = {}

        MUtils.completion_confirm = function()
            if vim.fn["coc#pum#visible"]() ~= 0 then
                return vim.fn["coc#pum#confirm"]()
            else
                return npairs.autopairs_cr()
            end
        end

        remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', { expr = true, noremap = true })

        -- New cool features and improvements

        -- 1. Smarter tab completion
        -- local check_back_space = function()
        --     local col = vim.fn.col('.') - 1
        --     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
        -- end

        -- keyset("i", "<TAB>", function()
        --     if vim.fn["coc#pum#visible"]() == 1 then
        --         return vim.fn["coc#pum#next"](1)
        --     elseif check_back_space() then
        --         return vim.fn["coc#refresh"]()
        --     else
        --         return "<TAB>"
        --     end
        -- end, { silent = true, noremap = true, expr = true })

        -- 11. Auto-import on completion
        vim.g.coc_enable_auto_import = 1

        -- 12. Enable snippets
        vim.g.coc_snippet_next = '<c-j>'
        vim.g.coc_snippet_prev = '<c-k>'

        -- 13. Show signature help on placeholder jump
        vim.api.nvim_create_autocmd("User", {
            group = "CocGroup",
            pattern = "CocJumpPlaceholder",
            command = "call CocActionAsync('showSignatureHelp')",
            desc = "Update signature help on jump placeholder"
        })

        -- 14. Highlight current symbol on CursorHold
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "CocGroup",
            command = "silent call CocActionAsync('highlight')",
            desc = "Highlight symbol under cursor on CursorHold"
        })

        -- 15. Add `:Fold` command to fold current buffer
        vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

        -- 16. Add `:OR` command for organize imports of the current buffer
        vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

        -- 17. Add custom status line info
        vim.o.statusline = vim.o.statusline .. '%{coc#status()}%{get(b:,"coc_current_function","")}'

        -- 18. Remap <C-f> and <C-b> for scroll float windows/popups
        vim.cmd([[
            if has('nvim-0.4.0') || has('patch-8.2.0750')
              nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
              nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
              inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
              inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
              vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
              vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
            endif
        ]])
    end
}

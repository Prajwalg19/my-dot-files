return {
    "https://github.com/tpope/vim-commentary",
        config = function()
vim.cmd [[
  autocmd FileType sql setlocal commentstring=--\ %s
]]
    end


}

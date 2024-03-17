local ok, _ = pcall(require, "nvim-tree")
if ok then
    vim.cmd([[autocmd VimEnter * lua require('nvim-tree.api').tree.close() ]])
end

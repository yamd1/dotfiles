vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

if pcall(require, 'nvim-tree') then
    vim.cmd [[autocmd VimEnter * lua require('nvim-tree.api').tree.close() ]]
end

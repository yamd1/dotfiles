vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.cmd [[autocmd VimEnter * lua require('nvim-tree.api').tree.close() ]]

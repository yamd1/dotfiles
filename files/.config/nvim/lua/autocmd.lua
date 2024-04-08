vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(client)
        vim.cmd("Trim")
        vim.lsp.buf.format({
            filter = function(c)
                local disabled_format_clients = { "intelephense" }
                return not vim.tbl_contains(disabled_format_clients, c.name)
            end,
        })
    end,
})

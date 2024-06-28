vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        -- Since conform does not format when using eslint, use lsp.buf.format instead
        vim.lsp.buf.format({ async = true })

        -- Format with conform.format() after LSP's formatting to achieve the desired format (e.g., intelephense -> pint)
        require("conform").format({ bufnr = args.buf })
    end,
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.phpstan.with({
            command = "/opt/app/vendor/bin/phpstan",
            args = { "analyze", "--error-format", "json", "--no-progress", "--memory-limit=-1", "$FILENAME" },
        }),
        null_ls.builtins.formatting.pint.with({
            command = "/opt/app/vendor/bin/pint",
        }),
        null_ls.builtins.formatting.prettier.with({
            command = "/opt/app/node_modules/.bin/prettier",
            args = { "$FILENAME" },
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        async = false,
                        bufnr = bufnr,
                        -- SEE: https://minerva.mamansoft.net/Notes/%F0%9F%93%9DNeovim%E3%81%A7nvim-lspconfig%E3%81%A8none-ls%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E4%BF%9D%E5%AD%98%E6%99%82%E3%81%AB%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88%E3%81%99%E3%82%8B%E3%81%A8%E7%95%B0%E3%81%AA%E3%82%8B%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88%E3%81%8C2%E5%BA%A6%E3%81%8B%E3%81%8B%E3%82%8B%E3%81%93%E3%81%A8%E3%81%8C%E3%81%82%E3%82%8B
                        filter = function(c)
                            local disabled_format_clients = { "lua_ls", "tsserver" }
                            return not vim.tbl_contains(disabled_format_clients, c.name)
                        end,
                    })
                end,
            })
        end
    end,
})

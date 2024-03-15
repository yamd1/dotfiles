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
            args = { "--write", "**/*.{js,json,yaml,yml,md}" }
        }),
        null_ls.builtins.formatting.lua_languarge_server,
        null_ls.builtins.formatting.tsserver
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
                        filter = function(client)
                            return client.name == "null-ls"
                        end,
                    })
                end,
            })
        end
    end,
})

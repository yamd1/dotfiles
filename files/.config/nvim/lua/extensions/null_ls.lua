local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.phpstan.with({
            command = "/opt/app/vendor/bin/phpstan",
            args = { "analyze", "--error-format", "json", "--no-progress", "--memory-limit=-1", "$FILENAME" }
        }),
        null_ls.builtins.formatting.pint.with({
            -- prefer_local = "vendor/bin"
            command = "/opt/app/vendor/bin/pint"
        }),
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "js", "json", "yaml", "yml", "md" },
            prefer_local = "node_modules/.bin"
        }),
        null_ls.builtins.completion.spell,
    },
})

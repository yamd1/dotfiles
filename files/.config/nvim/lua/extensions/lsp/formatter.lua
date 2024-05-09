require("conform").setup({
    formatters = {
        pint = {
            command = "vendor/bin/pint",
        },
        prettier = {
            command = "node_modules/.bin/prettier",
        },
        biome = {
            command = "node_modules/.bin/biome",
        },
    },
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "pint" },

        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettier", "biome" } },
        typescript = { { "prettier", "biome" } },
        yaml = { "prettier" },
        markdown = { "prettier" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
})

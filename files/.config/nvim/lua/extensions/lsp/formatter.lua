require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "/opt/app/vendor/bin/pint" },

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

require("conform").setup({
    formatters = {
        pint = {
            command = "vendor/bin/pint",
        },
        prettier = {
            command = "node_modules/.bin/prettier",
            cwd = require("conform.util").root_file({
                ".prettierrc.json",
                ".prettierrc",
                ".prettierrc.yml",
                ".prettierrc.yaml",
            }),
            require_cwd = true,
        },
        biome = {
            command = "node_modules/.bin/biome",
        },
        eslint = {
            command = "node_modules/.bin/eslint",
        },
    },
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "pint" },
        sql = { "sql-formatter" },

        javascript = { { "prettier", "biome", "eslint" } },
        typescript = { { "prettier", "biome", "eslint" } },
        typescriptreact = { { "prettier", "biome", "eslint" } },

        yaml = { "prettier" },
        yml = { "prettier" },
        markdown = { "prettier" },
        json = { "prettier" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

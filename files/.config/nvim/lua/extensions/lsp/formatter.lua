require("conform").setup({
    formatters = {
        pint = {
            command = "vendor/bin/pint",
        },
        prettier = {
            cwd = require("conform.util").root_file({
                ".prettierrc.json",
                ".prettierrc",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                ".prettier.config.js",
                ".prettierrc.mjs",
                "prettierrc.config.mjs",
                ".prettierrc.cjs",
                "prettierrc.config.cjs",
                ".prettierrc.toml",
            }),
            require_cwd = true,
        },
        biome = {
            cwd = require("conform.util").root_file({
                "biome.json",
                "biome.jsonc",
            }),
            require_cwd = true,
        },
        eslint = {
            command = "node_modules/.bin/eslint",
            cwd = require("conform.util").root_file({
                ".eslintrc.json",
            }),
            require_cwd = true,
        },
    },
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "pint" },
        sql = { "sql-formatter" },

        javascript = { "prettier", "biome", "eslint", stop_after_first = true },
        typescript = { "prettier", "biome", "eslint", stop_after_first = true },
        typescriptreact = { "prettier", "biome", "eslint", stop_after_first = true },

        yaml = { "prettier" },
        yml = { "prettier" },
        markdown = { "prettier" },
        json = { "prettier", "biome", stop_after_first = true },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

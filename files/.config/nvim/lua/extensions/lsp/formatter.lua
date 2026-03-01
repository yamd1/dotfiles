local is_windows = vim.fn.has("win32") == 1

require("conform").setup({
    formatters = {
        pint = {
            command = is_windows and "vendor/bin/pint.bat" or "vendor/bin/pint",
        },
        prettier = {
            command = is_windows and "node_modules/.bin/prettier.cmd" or "node_modules/.bin/prettier",
            cwd = require("conform.util").root_file({
                ".prettierrc.json",
                ".prettierrc",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                "prettier.config.js",
                ".prettierrc.mjs",
                "prettier.config.mjs",
                ".prettierrc.cjs",
                "prettier.config.cjs",
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
            command = is_windows and "node_modules/.bin/eslint.cmd" or "node_modules/.bin/eslint",
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

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua",
        "jsonnet",
        "markdown",
        "markdown_inline",
        "sql",
        "php",
        "rust",
        "php_only",
    },
    highlight = {
        enable = true,
    },
})

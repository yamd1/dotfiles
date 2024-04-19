require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua",
        "jsonnet",
    },
    highlight = {
        enable = true,
    },
})

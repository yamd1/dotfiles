require("kanagawa").setup({
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = false,
    terminalColors = true,
    colors = {
        palette = {},
        theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
                ui = {
                    gb_gutter = "none",
                },
            },
        },
    },
    overrides = function(_)
        return {}
    end,
    theme = "dragon",
    background = {
        dark = "dragon",
        light = "lotus",
    },
})

vim.cmd("colorscheme kanagawa")

-- ウィンドウの境界線の色をオーバーライド
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#2A2A37", bg = "None" })

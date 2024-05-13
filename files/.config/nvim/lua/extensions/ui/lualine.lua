require("lualine").setup({
    sections = {
        lualine_c = {
            {
                "filename",
                path = 3,
            },
        },
        lualine_x = {
            {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
                color = { fg = "#ff9e64" },
            },
        },
    },
})

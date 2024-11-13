local theme = require("lualine.themes.iceberg_dark")

local git_blame = require("gitblame")
vim.g.gitblame_display_virtual_text = 0 -- Display in lualine, so virtual_text will be hidden. It is dependent on lualine, so it is specified here.

require("lualine").setup({
    options = {
        theme = theme,
    },
    sections = {
        lualine_c = {
            {
                git_blame.get_current_blame_text,
                cond = git_blame.is_blame_text_available,
                color = { fg = "#414140" },
            },
        },
    },
})

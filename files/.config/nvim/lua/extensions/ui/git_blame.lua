vim.g.gitblame_message_when_not_committed = "-"
require("gitblame").setup({
    enabled = true,
    message_template = " <author>: <summary> (<date>)",
    date_format = "%Y-%m-%d %H:%M:%S",
    virtual_text_column = 1,
})

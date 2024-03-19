require("nvim-tree").setup({
    hijack_cursor = true,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 35,
        side = "left",
        signcolumn = "yes",
        preserve_window_proportions = true, -- SEE: https://github.com/nvim-tree/nvim-tree.lua/issues/1347
    },
    log = {
        enable = true,
        truncate = true,
        types = {
            --    diagnostics = true,
        },
    },
    actions = {
        change_dir = {
            enable = false,
        },
    },
})

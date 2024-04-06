require("nvim-tree").setup({
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
        },
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
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.del("n", "<C-v>", { buffer = bufnr })
        vim.keymap.del("n", "<C-x>", { buffer = bufnr })
        vim.keymap.del("n", "<C-t>", { buffer = bufnr })
        vim.keymap.set("n", "<M-v>", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "<M-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "<M-t>", api.node.open.tab, opts("Open: New Tab"))
    end,
})

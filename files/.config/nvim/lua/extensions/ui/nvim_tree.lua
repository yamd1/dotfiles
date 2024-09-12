require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
    },
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
    renderer = {
        highlight_git = true,
        highlight_opened_files = "name",
        icons = {
            glyphs = {
                git = {
                    unstaged = "!",
                    renamed = "»",
                    untracked = "?",
                    deleted = "✘",
                    staged = "✓",
                    unmerged = "",
                    ignored = "◌",
                },
            },
        },
    },
    view = {
        width = 35,
        side = "left",
        signcolumn = "no",
    },
    log = {
        enable = true,
        truncate = true,
        types = {
            diagnostics = true,
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
        vim.keymap.set("n", "<C-o>", function()
            local node = api.tree.get_node_under_cursor()
            if not node then
                print("Can not open explorer")
                return
            end

            local dir_path = ""
            if node.type == "directory" then
                dir_path = node.absolute_path
            elseif node.type == "file" then
                dir_path = node.absolute_path:match("(.*/)")
            else
                print("Unknown type")
                return
            end

            vim.fn.system("xdg-open " .. dir_path)
        end, opts("Open: Explorer"))
    end,
})

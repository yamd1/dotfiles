local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "x", '"_x', opts)
vim.keymap.set({ "n", "v" }, "s", '"_s', opts)
vim.keymap.set("v", "p", '"_xP', opts)

vim.keymap.set("n", "<Esc>", "<Cmd>nohl<CR><Esc>", opts)
vim.keymap.set("i", "jk", "<Cmd>nohl<CR><Esc>", opts)
vim.keymap.set("i", "jj", "<Cmd>nohl<CR><Esc>", opts)
vim.keymap.set("i", "kk", "<Cmd>nohl<CR><Esc>", opts)

vim.keymap.set("n", "<C-s>", "<Cmd>w!<CR>", opts)
vim.keymap.set("n", "<C-q>", "<Cmd>q<CR>", opts)
vim.keymap.set("n", "<C-Q>", "<Cmd>q!<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<C-w>>", opts)
vim.keymap.set("n", "<C-Left>", "<C-w><", opts)
vim.keymap.set("n", "<C-Up>", "<C-w>+", opts)
vim.keymap.set("n", "<C-Down>", "<C-w>-", opts)
vim.keymap.set("n", "<C-h>", "<Cmd>bprev<CR>", opts)
vim.keymap.set("n", "<C-l>", "<Cmd>bnext<CR>", opts)

vim.keymap.set("n", "<Leader>n", function()
    vim.cmd("set number!")
end, opts)
vim.keymap.set("n", "<Leader>q", "<Cmd>BDelete this<CR>", opts)
vim.keymap.set("n", "<Leader>Q", "<Cmd>BDelete other<CR>", opts)
vim.keymap.set("n", "<Leader>h", "<C-w>h", opts)
vim.keymap.set("n", "<Leader>l", "<C-w>l", opts)
vim.keymap.set("n", "<Leader>j", "<C-w>j", opts)
vim.keymap.set("n", "<Leader>k", "<C-w>k", opts)
vim.keymap.set("n", "<Leader>wh", "<C-w>H", opts)
vim.keymap.set("n", "<Leader>wl", "<C-w>L", opts)
vim.keymap.set("n", "<Leader>wj", "<C-w>J", opts)
vim.keymap.set("n", "<Leader>wk", "<C-w>K", opts)
vim.keymap.set("n", "<Leader>v", "<C-w>v", opts)
vim.keymap.set("n", "<Leader>s", "<C-w>s", opts)
vim.keymap.set("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>", opts)
vim.keymap.set("n", "<Leader>we", "<Cmd>NvimTreeFocus<CR>", opts)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>p", "<Cmd>Telescope find_files hidden=true<CR>", opts)
vim.keymap.set("n", "<Leader>P", "<Cmd>Telescope find_files hidden=true no_ignore=true<CR>", opts)
vim.keymap.set("n", "<Leader>fn", "<Cmd>Telescope find_files cwd=~/.config/nvim<CR>", opts)
vim.keymap.set("n", "<Leader>d", builtin.git_status, opts)
vim.keymap.set("n", "<Leader>b", builtin.buffers, opts)
vim.keymap.set("n", "<Leader>g", builtin.live_grep, opts)

vim.keymap.set("t", "}}", "<C-\\><C-n>")
vim.keymap.set({ "n", "t" }, "][", function()
    _terminal_toggle()
end, opts)
vim.keymap.set("n", "<leader>r", "<Cmd>RunCode<CR>", opts)

vim.api.nvim_set_keymap(
    "n",
    "n",
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    opts
)
vim.api.nvim_set_keymap(
    "n",
    "N",
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    opts
)
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local ops = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, ops)
        vim.keymap.set("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", ops)
        vim.keymap.set("n", "gv", "<C-w>v<Cmd>Lspsaga goto_definition<CR>", ops)
        vim.keymap.set("n", "gs", "<C-w>s<Cmd>Lspsaga goto_definition<CR>", ops)
        vim.keymap.set("n", "gh", "<Cmd>Lspsaga hover_doc<CR>", ops)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, ops)
        vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, ops)
        vim.keymap.set("n", "gn", "<Cmd>Lspsaga rename<CR>", ops)
        vim.keymap.set({ "n", "v" }, "ga", "<Cmd>Lspsaga code_action<CR>", ops)
        vim.keymap.set("n", "gr", "<Cmd>Lspsaga incoming_calls<CR>", ops)
        vim.keymap.set("n", "gf", function()
            vim.lsp.buf.format({ async = true })
        end, ops)
        vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, ops)
        vim.keymap.set("n", "g]", vim.diagnostic.goto_next, ops)
        vim.keymap.set("n", "ge", vim.diagnostic.open_float)
        vim.keymap.set("n", "<Leader><space>q", vim.diagnostic.setloclist)

        vim.keymap.set("n", "gb", "<Cmd>GitBlameToggle<CR>")

        vim.keymap.set(
            "i",
            "<Tab>",
            'copilot#Accept("<CR>")',
            { silent = true, expr = true, script = true, replace_keycodes = false }
        )
        vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
        vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
        vim.keymap.set("i", "<C-o>", "<Plug>(copilot-dismiss)")
        vim.keymap.set("i", "<C-s>", "<Plug>(copilot-suggest)")
    end,
})

vim.keymap.set("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gnormal")
end)
vim.keymap.set("n", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end)
vim.keymap.set("v", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual")
end)
vim.keymap.set("v", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual")
end)
vim.keymap.set("v", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("v", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end)

vim.keymap.set("n", "<Leader>m", require("treesj").toggle, opts)

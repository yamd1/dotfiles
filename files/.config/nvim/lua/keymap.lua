local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("v", "x", '"_x', opts)
vim.keymap.set("n", "s", '"_s', opts)
vim.keymap.set("v", "s", '"_s', opts)
vim.keymap.set("n", "<Esc>", ":nohl<Esc>", opts)

vim.keymap.set("n", "<C-s>", function()
    vim.cmd("Trim")
    vim.lsp.buf.format({ async = false })
    vim.cmd("w!")
end, opts)
vim.keymap.set("n", "<C-q>", ":q<CR>", opts)
vim.keymap.set("n", "<C-Q>", ":q!<CR>", opts)
vim.keymap.set("n", "<Leader>bd", ":bd<CR>", opts)
vim.keymap.set("n", "<Leader>ee", ":enew<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<C-w>>", opts)
vim.keymap.set("n", "<C-Left>", "<C-w><", opts)

vim.keymap.set("i", "jk", "<Esc>", opts)
vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("i", "kk", "<Esc>", opts)
vim.keymap.set("n", "<C-h>", ":bprev<CR>", opts)
vim.keymap.set("n", "<C-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<Leader>n", ":set number!<CR>", opts)

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

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>p", ":Telescope find_files hidden=true<CR>", opts)
vim.keymap.set("n", "<Leader>fn", ":Telescope find_files cwd=~/.config/nvim<CR>", opts)
vim.keymap.set("n", "<Leader>d", builtin.git_status, opts)
vim.keymap.set("n", "<Leader>b", builtin.buffers, opts)
vim.keymap.set("n", "<Leader>g", builtin.live_grep, opts)

vim.keymap.set("n", "]]", ":lua _terminal_toggle()<CR>", opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "]]", "<C-\\><C-n> :lua _terminal_toggle()<CR>", opts)
vim.keymap.set("n", "<C-e>", ":NvimTreeToggle<CR>", opts)
vim.keymap.set("n", "<leader>r", ":RunCode<CR>", opts)

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local ops = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, ops)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, ops)
        vim.keymap.set("n", "gh", vim.lsp.buf.hover, ops)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, ops)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, ops)
        vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, ops)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, ops)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, ops)
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, ops)
    end,
})

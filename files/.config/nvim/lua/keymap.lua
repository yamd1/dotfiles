vim.g.mapleader = " "
vim.keymap.set('n', 'x', '\"_x')
vim.keymap.set('v', 'x', '\"_x')
vim.keymap.set('n', 's', '\"_s')
vim.keymap.set('v', 's', '\"_s')
vim.keymap.set('n', '<Esc>', ':nohl<Esc>')

vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('n', '<C-q>', ':q<CR>')
vim.keymap.set('n', '<C-Q>', ':q!<CR>')
vim.keymap.set('n', '<C-w>', ':bd<CR>:bfirst<CR>')

-- Double press the j key to Esc key
vim.keymap.set('i', 'jk', '<Esc>', {
    silent = true
})
vim.keymap.set('i', 'jj', '<Esc>', {
    silent = true
})
vim.keymap.set('i', 'kk', '<Esc>', {
    silent = true
})

-- Move Buffer Keymap
vim.keymap.set('n', '<C-h>', ':bprev<CR>', {
    silent = true
})
vim.keymap.set('n', '<C-l>', ':bnext<CR>', {
    silent = true
})

local builtin = require("telescope.builtin")

vim.keymap.set('n', '<Leader>p', ":Telescope find_files hidden=true<CR>", {})
vim.keymap.set('n', '<Leader>d', builtin.git_status, {
    noremap = true
}) -- different
vim.keymap.set('n', '<Leader>b', builtin.buffers, {
    noremap = true
})
vim.keymap.set('n', '<Leader><Leader>', builtin.help_tags, {
    noremap = true
})

vim.keymap.set("n", "<Leader>fn", ":Telescope find_files cwd=~/.config/nvim<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>t", ":lua _terminal_toggle()<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '<C-e>', ':NvimTreeToggle<CR>', {
    silent = true
})

-- Move splited window
vim.keymap.set('n', '<Leader>h', '<C-w>h', {
    noremap = true
})
vim.keymap.set('n', '<Leader>l', '<C-w>l', {
    noremap = true
})
vim.keymap.set('n', '<Leader>j', '<C-w>j', {
    noremap = true
})
vim.keymap.set('n', '<Leader>k', '<C-w>k', {
    noremap = true
})
vim.keymap.set('n', '<Leader>v', '<C-w>v', {
    noremap = true
})
vim.keymap.set('n', '<Leader>s', '<C-w>s', {
    noremap = true
})

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n><cmd>lua _terminal_toggle()<CR>')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

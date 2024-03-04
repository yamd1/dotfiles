----------------------
-- Key Bindings
----------------------
vim.g.mapleader = " "
vim.keymap.set('n', 'x', '\"_x')
vim.keymap.set('s', 's', '\"_s')

vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('n', '<C-q>', ':q<CR>')

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
vim.keymap.set('n', '<C-j>', '<cmd>bprev<CR>', {
    silent = true
})
vim.keymap.set('n', '<C-k>', '<cmd>bnext<CR>', {
    silent = true
})

local builtin = require("telescope.builtin")

vim.keymap.set('n', '<C-p>', ":Telescope find_files hidden=true<cr>", {})
vim.keymap.set('n', '<Leader>d', builtin.git_status, {
    noremap = true
}) -- different
vim.keymap.set('n', '<Leader>b', builtin.buffers, {
    noremap = true
})
vim.keymap.set('n', '<Leader><Leader>', builtin.help_tags, {
    noremap = true
})

vim.keymap.set("n", "<Leader>fn", ":Telescope find_files cwd=~/.config/nvim<cr>", {})

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _terminal_toggle()<CR>", {noremap = true, silent = true})

-- nvim tree toggle setting
vim.keymap.set('n', '<C-e>', '<cmd>NvimTreeToggle<CR>', {
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

vim.keymap.set('n', '+', ':let @+ = @@<CR>', {
    noremap = true,
    silent = true
})


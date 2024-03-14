local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set('n', 'x', '\"_x')
vim.keymap.set('v', 'x', '\"_x')
vim.keymap.set('n', 's', '\"_s')
vim.keymap.set('v', 's', '\"_s')
vim.keymap.set('n', '<Esc>', ':nohl<Esc>')

vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('n', '<C-q>', ':q<CR>')
vim.keymap.set('n', '<C-Q>', ':q!<CR>')
vim.keymap.set('n', '<C-w>', ':bd')
vim.keymap.set('n', '<Leader>ee', ':enew<CR>')

vim.keymap.set('i', 'jk', '<Esc>', opts)
vim.keymap.set('i', 'jj', '<Esc>', opts)
vim.keymap.set('i', 'kk', '<Esc>', opts)

vim.keymap.set('n', '<C-h>', ':bprev<CR>', opts)
vim.keymap.set('n', '<C-l>', ':bnext<CR>', opts)

local builtin = require("telescope.builtin")

vim.keymap.set('n', '<Leader>p', ":Telescope find_files hidden=true<CR>", {})
vim.keymap.set("n", "<Leader>fn", ":Telescope find_files cwd=~/.config/nvim<CR>", {})
vim.keymap.set('n', '<Leader>d', builtin.git_status, opts)
vim.keymap.set('n', '<Leader>b', builtin.buffers, opts)
vim.keymap.set('n', '<Leader>hh', builtin.help_tags, opts)
vim.keymap.set('n', '<Leader>g', builtin.live_grep, opts)

vim.keymap.set("n", "<Leader><Leader>", ":lua _terminal_toggle()<CR>", opts)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n><cmd>lua _terminal_toggle()<CR>')
vim.keymap.set('n', '<C-e>', ':NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', opts)

vim.keymap.set('n', '<Leader>h', '<C-w>h', opts)
vim.keymap.set('n', '<Leader>l', '<C-w>l', opts)
vim.keymap.set('n', '<Leader>j', '<C-w>j', opts)
vim.keymap.set('n', '<Leader>k', '<C-w>k', opts)
vim.keymap.set('n', '<Leader>v', '<C-w>v', opts)
vim.keymap.set('n', '<Leader>s', '<C-w>s', opts)

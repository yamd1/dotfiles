----------------------
-- Key Bindings
----------------------
vim.g.mapleader = " "
vim.keymap.set('n', 'x', '\"_x')
vim.keymap.set('s', 's', '\"_s')

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

-- telescope
require('telescope').setup({
    defaults = {
        file_ignore_patterns = {"^.git/", "^.cache/"},
        vimgrep_arguments = {"rg", "--color=never", "--with-filename", "--line-number", "--column", "--smart-case",
                             "-uu"}
    },
    extensions = {
        fzf = {
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"

        }
    }
})
local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<Leader>f', '<cmd>lua require("telescope.builtin").find_files({ hidden = true })<cr>',{noremap = true})
vim.keymap.set('n', '<Leader>f', builtin.find_files, {})
vim.keymap.set('n', '<Leader>d', builtin.git_status, {
    noremap = true
}) -- different
vim.keymap.set('n', '<Leader>b', builtin.buffers, {
    noremap = true
})
vim.keymap.set('n', '<Leader><Leader>', builtin.help_tags, {
    noremap = true
})

-- nvim tree toggle setting
vim.keymap.set('n', '<C-t>', '<cmd>NvimTreeToggle<CR>', {
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

-- vim.api.nvim_set_keymap('n', '+', ':let @+ = @@<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '+', ':let @+ = @@<CR>', {
    noremap = true,
    silent = true
})

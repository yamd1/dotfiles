----------------------
-- Key Bindings
----------------------
vim.g.mapleader = " "
vim.keymap.set('n', 'x', '\"_x')
vim.keymap.set('s', 's', '\"_s')
vim.keymap.set('n', '<Esc>', ':nohl<Esc>')
vim.keymap.set('i', '<Esc>', ':nohl<Esc>')
vim.keymap.set('v', '<Esc>', ':nohl<Esc>')

vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('n', '<C-q>', ':q<CR>')
vim.keymap.set('n', '<C-Q>', ':q!<CR>')

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
vim.keymap.set('n', '<C-h>', '<cmd>bprev<CR>', {
  silent = true
})
vim.keymap.set('n', '<C-l>', '<cmd>bnext<CR>', {
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

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _terminal_toggle()<CR>", { noremap = true, silent = true })

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
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

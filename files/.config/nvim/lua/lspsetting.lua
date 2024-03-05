-- -- coc autocomplete
-- vim.api.nvim_set_keymap('i', '<C-j>', "pumvisible() ? coc#pum#next(1) : '<C-j>'", {
--     silent = true,
--     expr = true
-- })
-- vim.api.nvim_set_keymap('i', '<C-k>', "pumvisible() ? coc#pum#prev(1) : '<C-k>'", {
--     silent = true,
--     expr = true
-- })
-- vim.api.nvim_set_keymap('i', '<Enter>', "pumvisible() ? coc#pum#confirm() : '<Enter>'", {
--     silent = true,
--     expr = true
-- })
-- vim.api.nvim_set_keymap('i', '<Esc>', "pumvisible() ? coc#pum#cancel() : '<Esc>'", {
--     silent = true,
--     expr = true
-- })
-- vim.api.nvim_set_keymap('i', '<C-h>', "pumvisible() ? coc#pum#cancel() : '<C-h>'", {
--     silent = true,
--     expr = true
-- })
--
-- -- coc difinition jump
-- vim.api.nvim_set_keymap('n', '<C-]>', '<Plug>(coc-definition)', {
--     silent = true
-- })
--
-- -- coc hints display scroll
-- vim.api.nvim_set_keymap('i', '<C-f>', "coc#float#has_scroll() ? coc#float#scroll(1) : '<Right>'", {
--     silent = true,
--     expr = true,
--     nowait = true
-- })
-- vim.api.nvim_set_keymap('i', '<C-b>', "coc#float#has_scroll() ? coc#float#scroll(0) : '<Left>'", {
--     silent = true,
--     expr = true,
--     nowait = true
-- })

require("mason").setup()
require("mason-lspconfig").setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}


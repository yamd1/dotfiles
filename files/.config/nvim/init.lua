require("base")
require("plugins")
require("colorscheme")
require("_toggleterm")
require("_telescope")
require("keymap")
require("lspsetting")
require("git-settings")
require("clipboard")
require("_nvim-tree")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_dirhistmax = 0
vim.opt.shiftwidth = 4
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.textwidth = 0
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.scriptencoding = 'utf-8'
vim.opt.background = "dark"
vim.opt.re = 0
vim.opt.hidden = true
vim.g.editorconfig = true
vim.opt.list = true
vim.listchars = {
    tab = '>>',
    trail = '-',
    nbsp = '+'
}
vim.opt.termguicolors = true
vim.opt.winblend = 0 -- ウィンドウの不透明度
vim.opt.pumblend = 0 -- ポップアップメニューの不透明度

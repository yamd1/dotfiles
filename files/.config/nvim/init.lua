-- https://zenn.dev/hisasann/articles/neovim-settings-to-lua
require("base")
require("plugins")
require("colorscheme")
require("keymap")
require("lspsetting")
-- require("forWindows")
if pcall(require, 'nvim-tree') then
    require('nvim-tree').setup {
        hijack_cursor = true,
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = ""
            }
        },
        view = {
            width = 40,
            side = 'left',
            signcolumn = 'yes'
        },
        log = {
            enable = true,
            truncate = true,
            types = {
                --    diagnostics = true,
            }
        }
    }
end
require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            "^.git/",
            "^.cache/",
            "^Library/",
            "Parallels",
            "^Movies",
            "^Music",
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-uu",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})
require("telescope").load_extension("fzf")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.expandtab = true
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
vim.g.netrw_dirhistmax = 0
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
vim.opt.clipboard:append({ 'unnamedplus' })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "nvim-lua/plenary.nvim" },
    { "MunifTanjim/nui.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "junegunn/fzf.vim" },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp'
        }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/vim-vsnip'
        }
    },

    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'saadparwaiz1/cmp_luasnip' },
    { "L3MON4D3/LuaSnip" },

    -- Formatter
    {
        'nvimtools/none-ls.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            local none_ls = require("none-ls")
            none_ls.setup {
                sources = {
                    none_ls.builtins.diagnostics.phpstan
                }
            }
        end
    },
    {
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
        },
    },
    { "MunifTanjim/prettier.nvim" },
    { "ntpeters/vim-better-whitespace" },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    { 'lewis6991/gitsigns.nvim' },
    { "sindrets/diffview.nvim" },
    { 'tpope/vim-fugitive' },
    { 'rbong/vim-flog' },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup()
        end
    },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { "lukas-reineke/indent-blankline.nvim" },
    { "nvim-lualine/lualine.nvim" },
    { "akinsho/bufferline.nvim" },
    { 'ap/vim-buftabline' },
    { 'CRAG666/code_runner.nvim' },
    { 'github/copilot.vim' },
}
local opts = {
    checker = {
        enabled = true
    }
}

require("lazy").setup(plugins, opts)

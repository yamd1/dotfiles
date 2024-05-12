-- cspell: disable
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
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    { "junegunn/fzf.vim" },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
    },

    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/vim-vsnip",
        },
    },

    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },

    {
        "stevearc/conform.nvim",
        opts = {},
    },

    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "davidmh/cspell.nvim",
        },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    { "ntpeters/vim-better-whitespace" },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    { "monaqa/dial.nvim" },
    { "lewis6991/gitsigns.nvim" },
    { "sindrets/diffview.nvim" },
    {
        "akinsho/toggleterm.nvim",
        config = true,
    },
    { "nvim-tree/nvim-tree.lua" },
    { "nvim-tree/nvim-web-devicons" },
    { "lukas-reineke/indent-blankline.nvim" },
    { "nvim-lualine/lualine.nvim" },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    { "cappyzawa/trim.nvim" },
    { "kevinhwang91/nvim-hlslens" },

    { "norcalli/nvim-colorizer.lua" },
    { "CRAG666/code_runner.nvim" },
    { "monaqa/dial.nvim" },
    { "github/copilot.vim" },
    { "ixru/nvim-markdown" },
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup({})
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}

-- SEE: https://github.com/folke/lazy.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
local opts = {}

require("lazy").setup(plugins, opts)

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
        opts = {
            lsp = {
                progress = {
                    enabled = false,
                },
            },
            messages = {
                enabled = false,
            },
            notify = {
                enabled = false,
            },
        },
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
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        main = "nvim-treesitter.configs",
        opts = {
            highlight = { enable = true },
            ensure_installed = {
                "lua",
                "jsonnet",
                "sql",
                "tsx",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "CursorMoved",
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
    { "f3fora/cmp-spell" },
    { "L3MON4D3/LuaSnip" },

    { "stevearc/conform.nvim" },
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
        "nvimdev/lspsaga.nvim",
        commit = "ad61778283f26a9fa2c5a8d2f0aca52ba49f32f3",
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
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
    {
        "f-person/git-blame.nvim",
        event = "VeryLazy",
        opts = {},
    },

    { "sindrets/diffview.nvim" },
    {
        "akinsho/toggleterm.nvim",
        config = true,
    },
    { "nvim-tree/nvim-tree.lua" },
    { "nvim-tree/nvim-web-devicons" },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, lazy = false },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    { "cappyzawa/trim.nvim" },
    { "kevinhwang91/nvim-hlslens" },
    {
        "b0o/incline.nvim",
        event = "VeryLazy",
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
    },
    {
        "Wansmer/treesj",
        -- dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    { "kazhala/close-buffers.nvim" },
    { "norcalli/nvim-colorizer.lua" },
    { "CRAG666/code_runner.nvim" },
    { "monaqa/dial.nvim" },
    { "ixru/nvim-markdown" },
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
        end,
    },
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({})
    --     end,
    -- },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
        opts = {
            provider = "copilot",
            auto_suggestions_provider = "copilot",
            behaviour = {
                auto_suggestions = false,
                auto_set_highlight_group = true,
                auto_set_keymaps = true,
                auto_apply_diff_after_generation = false,
                support_paste_from_clipboard = false,
                minimize_diff = true,
            },

            windows = {
                position = "right",
                wrap = true,
                width = 30,
            },
            input = {
                prefix = "> ",
                height = 8,
            },
            edit = {
                border = "rounded",
                start_insert = true,
            },
            ask = {
                floating = false,
                start_insert = true,
                border = "rounded",
                focus_on_apply = "ours",
            },
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "github/copilot.vim",
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}

-- SEE: https://github.com/folke/lazy.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
local opts = {}

require("lazy").setup(plugins, opts)

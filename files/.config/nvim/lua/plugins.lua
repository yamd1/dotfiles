local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({
        border = "rounded"
      })
    end
  }
})

return packer.startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({ "nvim-lua/plenary.nvim" }) -- Common utilities
  use({ "MunifTanjim/nui.nvim" })

  use({ "nvim-telescope/telescope.nvim" })
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use({ "nvim-telescope/telescope-file-browser.nvim" })

  use({ "nvim-treesitter/nvim-treesitter" })

  -- Colorschemes
  use({ "rebelot/kanagawa.nvim" })

  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp'
    }
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
    }
  }

  use {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip'
  }

  use({
    "neoclide/coc.nvim",
    branch = 'release'
  })
  use({ "junegunn/fzf.vim" })

  use({ "L3MON4D3/LuaSnip" }) -- snippet engine

  -- Formatter
  use({ "MunifTanjim/prettier.nvim" })
  use({ "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" }})

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  })

  use({ 'lewis6991/gitsigns.nvim' })
  use({ "sindrets/diffview.nvim" })
  use({ 'tpope/vim-fugitive' })
  use({ 'rbong/vim-flog' })

  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end }

  use({ 'nvim-tree/nvim-tree.lua' })
  use({ 'nvim-tree/nvim-web-devicons' })

  use({ "nvim-lualine/lualine.nvim" })
  use({ "akinsho/bufferline.nvim" })
  use({ 'ap/vim-buftabline' })

  use({ 'github/copilot.vim' })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

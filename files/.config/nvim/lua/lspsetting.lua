require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup {
    ensure_installed = {
      "intelephense",
      "marksman",
      "lua_ls",
      "rust_analyzer",
      "denols",
      "jsonls",
      "tsserver",
      "hydra_lsp", -- yaml
      "bashls" -- bash
    },
}

-- After setting up mason-lspconfig you may set up servers via lspconfig
require("lspconfig").lua_ls.setup {}
require("lspconfig").rust_analyzer.setup {}
require("lspconfig").intelephense.setup {}
require("lspconfig").marksman.setup {}
require("lspconfig").denols.setup {}
require("lspconfig").jsonls.setup {}
require("lspconfig").tsserver.setup {}
require("lspconfig").hydra_lsp.setup {}
require("lspconfig").bashls.setup {}


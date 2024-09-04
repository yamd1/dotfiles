require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "tsserver",
        "jsonls",
        "intelephense@1.11.8",
        "rust_analyzer",
        "eslint",
        "terraformls",
        "tflint",
        "yamlls",
        "biome",
    },
})

local util = require("lspconfig.util")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
        })

        require("lspconfig").rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end,
            checkOnSave = {
                command = "clippy",
            },
        })

        require("lspconfig").terraformls.setup({
            capabilities = capabilities,
            filetype = { "terraform", "terraform-vars", "hcl" },
        })

        require("lspconfig").biome.setup({
            capabilities = capabilities,
            cmd = {
                "biome",
                "lsp-proxy",
            },
            root_dir = util.root_pattern("biome.json", "biome.jsonc"),
            single_file_support = false,
            filetype = {
                "javascript",
                "javascriptreact",
                "json",
                "jsonc",
                "typescript",
                "typescript.tsx",
                "typescriptreact",
            },
        })
    end,
})

require("mason-null-ls").setup({
    handlers = {},
})

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" }, -- For vsnip users.
        { name = "spell" },
    }, {
        { name = "buffer" },
    }),
    experimental = {
        ghost_text = true,
    },
})

cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "git" },
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "stylua",
        "cspell",
        "sql-formatter",
    },
})

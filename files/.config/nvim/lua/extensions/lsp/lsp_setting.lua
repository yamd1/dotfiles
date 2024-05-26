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
        "intelephense",
        "rust_analyzer",
        "eslint",
        "terraformls",
        "tflint",
        "yamlls",
    },
})

-- local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
        })

        require("lspconfig").rust_analyzer.setup({
            capabilities = capabilities,
            checkOnSave = {
                command = "clippy",
            },
        })

        require("lspconfig").terraformls.setup({
            capabilities = capabilities,
            filetype = { "terraform", "terraform-vars", "hcl" },
        })

        require("lspconfig").eslint.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = require("extensions.lsp.eslint").on_attach,
            settings = require("extensions.lsp.eslint").settings,
        })

        require("lspconfig").biome.setup({
            capabilities = capabilities,
            cmd = {
                vim.loop.cwd() .. "/node_modules/.bin/biome",
                "lsp-proxy",
                "--config-path",
                vim.loop.cwd() .. "/biome.json",
            },
            filetype = {
                "javascript",
                "javascriptreact",
                "json",
                "jsonc",
                "typescript",
                "typescript.tsx",
                "typescriptreact",
                "svelte",
                "vue",
            },
        })

        require("lspconfig").jsonnet_ls.setup({
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            flags = {
                debounce_text_changes = 150,
            },
            cmd = { "jsonnet-language-server", "--lint" },
            settings = {
                formatting = {
                    UseImplicitPlus = true,
                },
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

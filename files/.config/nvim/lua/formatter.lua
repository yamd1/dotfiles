local null_ls = require "null-ls"
null_ls.setup {
    sources = {
        null_ls.builtins.formatting.deno_fmt.with {
            condition = function(utils)
                return not (utils.has_file { ".prettierrc", ".prettierrc.js", "deno.json", "deno.jsonc" })
            end,
        },
        null_ls.builtins.formatting.prettier.with {
            condition = function(utils)
                return utils.has_file { ".prettierrc", ".prettierrc.js" }
            end,
            prefer_local = "node_modules/.bin",
        },
    },
    capabilities = common_config.capabilities,
    on_attach = common_config.on_attach,
}

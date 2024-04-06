local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
local cspell_config = {
    config_file_preferred_name = "cspell.json",
    on_add_to_dictionary = function(payload)
        os.execute(string.format("sort %s -o %s", payload.dictionary_path, payload.dictionary_path))
    end,
}

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.phpstan.with({
            command = "/opt/app/vendor/bin/phpstan",
            args = { "analyze", "--error-format", "json", "--no-progress", "--memory-limit=-1", "$FILENAME" },
        }),
        null_ls.builtins.formatting.pint.with({
            command = "/opt/app/vendor/bin/pint",
        }),
        null_ls.builtins.formatting.prettier.with({
            command = "/opt/app/node_modules/.bin/prettier",
            args = { "$FILENAME" },
            filetypes = { "js", "ts" },
        }),
        null_ls.builtins.diagnostics.terraform_validate,
        require("cspell").diagnostics.with({
            config = cspell_config,
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity.INFO
            end,
        }),
        require("cspell").code_actions.with({
            config = cspell_config,
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function(client)
                    vim.lsp.buf.format({
                        filter = function(c)
                            local disabled_format_clients = { "intelephense" }
                            return not vim.tbl_contains(disabled_format_clients, c.name)
                        end,
                    })
                end,
            })
        end
    end,
})

if vim.fn.filereadable("~/.local/share/cspell/vim.txt.gz") ~= 1 then
    local vim_dictionary_url = "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
    io.popen("curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs " .. vim_dictionary_url)
end

if vim.fn.filereadable("~/.local/share/cspell/user.txt") ~= 1 then
    io.popen("mkdir -p ~/.local/share/cspell")
    io.popen("touch ~/.local/share/cspell/user.txt")
end

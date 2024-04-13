local null_ls = require("null-ls")
local cspell_config = {
    find_json = function(_)
        return vim.fn.expand("~/dotfiles/cspell.json")
    end,
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
                diagnostic.severity = vim.diagnostic.severity.WARN
            end,
        }),
        require("cspell").code_actions.with({
            config = cspell_config,
        }),
        null_ls.builtins.formatting.yamlfmt,
    },
    should_attach = function(bufnr)
        -- NvimTreeにcspellがアタッチされないように
        return not vim.api.nvim_buf_get_name(bufnr):match("NvimTree_1$")
    end,
})

if vim.fn.filereadable("~/.local/share/cspell/vim.txt.gz") ~= 1 then
    local vim_dictionary_url = "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
    io.popen("curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs " .. vim_dictionary_url)
end

if vim.fn.filereadable("~/.local/share/cspell/local.txt") ~= 1 then
    io.popen("mkdir -p ~/.local/share/cspell")
    io.popen("touch ~/.local/share/cspell/local.txt")
end

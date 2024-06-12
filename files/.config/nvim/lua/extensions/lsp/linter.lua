local nvim_path = vim.fn.stdpath("config")
local cspell_config = {
    find_json = function(_)
        return vim.fn.expand(nvim_path .. "/cspell.json")
    end,
    on_add_to_dictionary = function(payload)
        os.execute(string.format("sort %s -o %s", payload.dictionary_path, payload.dictionary_path))
    end,
}

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.phpstan.with({
            command = "vendor/bin/phpstan",
            args = {
                "analyse",
                "--error-format",
                "json",
                "--no-progress",
                "--memory-limit=-1",
                "$FILENAME",
            },
            temp_dir = "/tmp",
        }),
        require("null-ls").builtins.diagnostics.terraform_validate,
        require("cspell").diagnostics.with({
            config = cspell_config,
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity.WARN
            end,
        }),
        require("cspell").code_actions.with({
            config = cspell_config,
        }),
    },
    should_attach = function(bufnr)
        -- NvimTreeにcspellがアタッチされないように
        return not vim.api.nvim_buf_get_name(bufnr):match("NvimTree_1$")
    end,
})

local vim_dict_path = nvim_path .. "/cspell/vim.txt.gz"
if vim.fn.filereadable(vim_dict_path) ~= 1 then
    local vim_dictionary_url = "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
    io.popen("curl -fsSLo " .. vim_dict_path .. " --create-dirs " .. vim_dictionary_url)
end

local local_dict_path = nvim_path .. "/cspell/local.txt"
if vim.fn.filereadable(local_dict_path) ~= 1 then
    io.popen("touch " .. local_dict_path)
end

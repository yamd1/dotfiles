vim.cmd(":command -nargs=1 Lspbuf :lua LspAttachBuf(<f-args>)")

function _G.LspAttachBuf(lang)
    if lang == "php" then
        vim.lsp.start({
            name = "intelephense",
            cmd = { "intelephense", "--stdio" },
            root_dir = vim.fs.dirname(vim.fs.find({ ".composer" }, { upward = true })[1]),
        })
    elseif lang == "lua" then
        vim.lsp.start({
            name = "lua_ls",
            cmd = { "lua-language-server" },
            root_dir = vim.fs.dirname(vim.fs.find({ ".luarc.json" }, { upward = true })[1]),
        })
    else
        print("Don't setup already. See" .. vim.cmd(":luafiles %"))
    end
end

vim.cmd("command -nargs=0 SaveOnWithoutFormat :lua SaveOnWithoutFormat()")

function _G.SaveOnWithoutFormat()
    vim.cmd("set eventignore=BufWritePre")
    local ok, err = pcall(vim.cmd, "write!")
    vim.cmd("set eventignore=")
    if not ok then
        vim.notify(err, vim.log.levels.ERROR)
    end
end

vim.cmd(":command -nargs=0 SaveOnWithoutFormat :lua SaveOnWithoutFormat()")

function _G.SaveOnWithoutFormat()
    vim.cmd(":set eventignore=BufWritePre")
    vim.cmd(":w!")
    vim.cmd(":set eventignore=")
end

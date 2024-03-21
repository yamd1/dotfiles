vim.cmd(":command -nargs=0 SaveOnWithoutFormat :lua SaveOnWithoutFormat()")

function _G.SaveOnWithoutFormat()
    vim.g.format_on_save = false
    vim.cmd(":w!")
end

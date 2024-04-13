vim.api.nvim_command("command -nargs=0 DiffWindows :lua DiffWindows()")
function _G.DiffWindows()
    vim.api.nvim_command("NvimTreeClose")
    vim.api.nvim_command("windo diffthis")
end

vim.api.nvim_command("command -nargs=0 DiffWindowsOff :lua DiffWindowsOff()")
function _G.DiffWindowsOff()
    vim.api.nvim_command("diffoff!")
end

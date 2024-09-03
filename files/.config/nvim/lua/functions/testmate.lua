vim.cmd("command -nargs=0 Testmate :lua Testmate()")

function _G.Testmate()
    local fname = vim.api.nvim_buf_get_name(0)
    local command = 'echo "' .. fname .. '" | testmate -c'

    local reply = vim.fn.system(command)

    vim.cmd("vnew " .. reply)
end

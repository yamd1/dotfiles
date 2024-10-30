-- SEE: https://github.com/neovim/neovim/issues/28611
local function my_paste(_)
    return function(_)
        local content = vim.fn.getreg('"')
        return vim.split(content, "\n")
    end
end

vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        -- No OSC52 paste action since wezterm doesn't support it
        -- Should still paste from nvim
        ["+"] = my_paste("+"),
        ["*"] = my_paste("*"),
    },
    cache_enabled = 1,
}

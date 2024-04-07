local Terminal = require("toggleterm.terminal").Terminal
local _terminal = Terminal:new({
    direction = "float",
    float_opts = {
        border = "curved",
    },
    on_open = function(term)
        vim.cmd("startinsert!")
    end,

    on_close = function(term)
        vim.cmd("startinsert!")
    end,
})

function _terminal_toggle()
    _terminal:toggle()
end

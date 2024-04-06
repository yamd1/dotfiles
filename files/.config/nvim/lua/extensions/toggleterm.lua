local Terminal = require("toggleterm.terminal").Terminal
local _terminal = Terminal:new({
    direction = "float",
    float_opts = {
        border = "curved",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
    end,
    -- function to run on closing the terminal
    on_close = function(term)
        vim.cmd("startinsert!")
    end,
})

function _terminal_toggle()
    _terminal:toggle()
end

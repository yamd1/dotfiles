local Terminal = require("toggleterm.terminal").Terminal
local _terminal = Terminal:new({
    direction = "float",
    float_opts = {
        border = "curved",
    },
    highlights = {
        FloatBorder = {
            guifg = "#54546D",
        },
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

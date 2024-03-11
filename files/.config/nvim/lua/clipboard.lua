-- SEE: https://github.com/neovim/neovim/issues/10223
vim.o.clipboard = 'unnamedplus'
vim.g.clipboard = {
    name = 'WL-Clipboard with ^M Trim',
    copy = {
        ['+'] = 'wl-copy --foreground --type text/plain',
        ['*'] = 'wl-copy --foreground --type text/plain --primary',
    },
    paste = {
        ['+'] = function() return vim.fn.systemlist('wl-paste --no-newline | tr -d "\r"', '', 1) end,
        ['*'] = function() return vim.fn.systemlist('wl-paste --no-newline --primary | tr -d "\r"', '', 1) end,
    },
    cache_enabled = 1,
}

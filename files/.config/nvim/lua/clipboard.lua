-- Set clipboard options to enable sharing with Windows
-- https://zenn.dev/shoseisan/articles/d7565884f5846b
vim.cmd('set clipboard+=unnamedplus')
vim.o.clipboard = 'unnamedplus'
vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
        ['+'] = 'win32yank -i',
        ['*'] = 'win32yank -i'
    },
    paste = {
        ['+'] = 'win32yank -o',
        ['*'] = 'win32yank -o'
    },
    cache_enabled = 1
}

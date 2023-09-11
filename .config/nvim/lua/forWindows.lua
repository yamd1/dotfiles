
-- Set clipboard options to enable sharing with Windows
-- https://zenn.dev/shoseisan/articles/d7565884f5846b
vim.cmd('set clipboard+=unnamedplus')
vim.o.clipboard = 'unnamedplus'
vim.g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = 'win32yank.exe -i',
    ['*'] = 'win32yank.exe -i',
  },
  paste = {
    ['+'] = 'win32yank.exe -o',
    ['*'] = 'win32yank.exe -o',
  },
  cache_enabled = 1,
}


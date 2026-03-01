vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.g.netrw_dirhistmax = 0
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.textwidth = 0
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.indentexpr = ""
vim.opt.hlsearch = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.encoding = "utf-8"
vim.opt.background = "dark"
vim.opt.re = 0
vim.opt.hidden = true
vim.g.editorconfig = true
vim.opt.list = true
vim.o.clipboard = "unnamedplus"
vim.opt.number = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.diagnostic.config({ severity_sort = true })
vim.opt.foldenable = true
vim.opt.foldmethod = "manual"
vim.opt.laststatus = 3
vim.opt.cmdheight = 0

if vim.fn.has("win32") == 1 then
    vim.opt.shell = "pwsh"
    vim.opt.shellcmdflag =
        "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

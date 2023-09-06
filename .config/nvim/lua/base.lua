vim.scriptencoding = "utf-8"
vim.wo.number = true
vim.g.mapleader = " "

local function openOrCreateFile(filename)
    local file = io.open(filename, "r")
    if file then
        io.close(file)
        vim.cmd("e " .. filename)
    else
        os.execute("touch " .. filename)
        vim.cmd("e " .. filename)
    end
end

local function openOrCreateDailyFile(format)
    local date = os.date("%Y-%m-%d")
    local filename = string.format("~/_/%s_%s.markdown", format, date)
    openOrCreateFile(filename)
end

-- Open hoge file
vim.api.nvim_create_user_command("Note", function(opts)
  openOrCreateDailyFile("note")
end, {})
vim.api.nvim_create_user_command("Daily", function(opts)
  openOrCreateDailyFile("daily")
end, {})
vim.api.nvim_create_user_command("Weekly", function(opts)
	vim.cmd("e " .. "~/_/weekly.markdown")
end, {})


function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- lazygit settings
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})

    -- 同一セッション内でTerminalを開いたことが無い場合、't'にkeymapが設定されていないためifにて分岐する
    if #(vim.api.nvim_buf_get_keymap(term.bufnr, 't')) > 0 then
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-w>')
    end
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  -- vim.cmd('autocmd! TermOpen term://* lua unset_terminal_keymaps()')
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})


-- toggleterm settings
local _terminal = Terminal:new({
    direction = "float",
    float_opts = {
        border = "double"
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
     vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    _terminal:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _terminal_toggle()<CR>", {noremap = true, silent = true})





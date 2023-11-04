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

require("code_runner").setup({
    filetype = {
        php = function(...)
            local fname = vim.fn.expand("%:t")
            if fname:match("Test.php$") then
                return "php artisan test --testdox $file"
            end
            return "php artisan tinker --ansi .tmp/$fileName $XDG_CONFIG_HOME/php/exit.php"
        end,
        bash = function(...)
            local fname = vim.fn.expand("%:t")
            if fname ~= "" then
                return "bash " .. fname
            end

            local new_fname = "/tmp/" .. os.time() .. ".sh"
            vim.api.nvim_command("write! " .. new_fname)
            return "bash " .. new_fname
        end,
        rust = {},
        [""] = function()
            local shebang = vim.api.nvim_buf_get_lines(0, 0, 1, 1)[1]
            if shebang:match("<?php") then
                vim.api.nvim_command("write! " .. ".tmp/" .. os.time() .. ".php")
            elseif shebang:match("bash") then
                vim.api.nvim_command("write! " .. "/tmp/" .. os.time() .. ".sh")
            end
            vim.api.nvim_command("RunCode")
        end,
    },
})

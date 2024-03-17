vim.cmd(":command -nargs=1 Tmp :lua SaveBuf(<f-args>)")

function _G.SaveBuf(lang)
    if lang == "php" then
        vim.cmd(":w tempCodeRunnerFile.php")
    elseif lang == "ts" then
        vim.cmd(":w tmp.ts")
    else
        print("Don't setup already. See" .. vim.cmd(":luafiles %"))
    end
end

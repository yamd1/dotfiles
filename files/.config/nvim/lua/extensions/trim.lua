require("trim").setup({
    -- if you want to remove multiple blank lines
    patterns = {
        [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
    },
})

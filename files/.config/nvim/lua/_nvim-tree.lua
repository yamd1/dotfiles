if pcall(require, 'nvim-tree') then
    require('nvim-tree').setup {
        hijack_cursor = true,
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = ""
            }
        },
        view = {
            width = 40,
            side = 'left',
            signcolumn = 'yes'
        },
        log = {
            enable = true,
            truncate = true,
            types = {
                --    diagnostics = true,
            }
        }
    }
end


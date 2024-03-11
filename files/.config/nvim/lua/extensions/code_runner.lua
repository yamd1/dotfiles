require("code_runner").setup {
    filetype = {
        php = {
            "php artisan tinker --ansi $fileName $XDG_CONFIG_HOME/php/exit.php"
        }
    },
    temporaryFileName = "tempCodeRunnerFile"
}
